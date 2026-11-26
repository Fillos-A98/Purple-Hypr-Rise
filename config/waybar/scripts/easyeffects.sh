#!/bin/bash
preset=$(easyeffects --last-loaded-preset input 2>/dev/null)
echo "{\"text\":\"${preset:-No preset}\",\"tooltip\":\"EasyEffects: ${preset:-No preset}\"}"
