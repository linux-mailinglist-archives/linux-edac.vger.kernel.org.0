Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677F11513F6
	for <lists+linux-edac@lfdr.de>; Tue,  4 Feb 2020 02:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgBDBZ1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Feb 2020 20:25:27 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38261 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgBDBZ1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Feb 2020 20:25:27 -0500
Received: by mail-vs1-f65.google.com with SMTP id r18so10312596vso.5
        for <linux-edac@vger.kernel.org>; Mon, 03 Feb 2020 17:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qumulo.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=FOpyn/lGZsK5IrzRK0NTTrZUmwjYVH3HfG5GIy00uk8=;
        b=lDnvTCyM3X5oL5Te4OFwkQGYXLVmKwj4WrAh1gn5dPTfoYCASRSLAz0LXabmdNgh6c
         jBgqDCXUeCbswMlJWIdMy/qQRmkm95I8A5+Oap4XA9yMN12VOfBiRkTJSu6FUpKgXzgS
         BP27oX/r8+qN9n69SaOHLQ5bfOiZy5u6+dZ84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FOpyn/lGZsK5IrzRK0NTTrZUmwjYVH3HfG5GIy00uk8=;
        b=eIeaQOW+KBB6Y1DD6iJmn00vocmbGMVEe0UJZwIsMN/lF3pFx4iE1r2p8H42terpVp
         oEgvwuJzo6tTbBpSNlzf1lwo9ny/XYpJ8S0jrWwSJRj111oujD6Tn+2DgOiiGai5g92V
         YSm4iFcUse5vGSLfZbVrnoAHfO0FBh7tijkg50+gd8y7e25EYJhQucC9bZToMs/nIdwf
         7ukGM2zY2j3Kt8toPMn+UsvRh4hpnA4FQEWtvFHv3BbblDThH/QjJqDSEt0tXWUjWsyz
         YDIx0RJ6yYhKxJoGloJeV0RAIf264cXDILeL5eOvunZEjS/XpOet0Nl/KRvyju6iXbw3
         4T/Q==
X-Gm-Message-State: APjAAAUayNzJVj7sqPNxClAc/t/LlLUSWDGFPt3sqVPWbAGNdi/WUcJi
        9PGfbKXWIZMFm3mxHQPX7Ry0k9GbIz6iEVyBAEs+fcSytOA=
X-Google-Smtp-Source: APXvYqwYkYFfAKqGv1+Z/r5Wx6gK2gHC8/5YZffcxE9anXsUJklOYjUPCfS/fZ/bZMecDqw2JDbPT21AL76qTMExZ3Y=
X-Received: by 2002:a05:6102:127c:: with SMTP id q28mr16574954vsg.72.1580779526106;
 Mon, 03 Feb 2020 17:25:26 -0800 (PST)
MIME-Version: 1.0
From:   Dan Pehush <dpehush@qumulo.com>
Date:   Mon, 3 Feb 2020 17:25:15 -0800
Message-ID: <CACNqQuQNsVyqxW2yq_W=EN2f0q7oP-Fkfe9vXWV4wMznZ093jA@mail.gmail.com>
Subject: Qumulo: a question about UECC detection from the ie31200_edac ko
To:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi All,

   My name is Daniel Pehush, I work on the hardware team at an
enterprise data storage company called Qumulo Inc. We want to be able
to have our server systems kernel PANIC on the occurrence of a UECC
error. A UECC should be treated as an interrupt. We were working with
Intel to get resolution for this desired behavior, and they have
directed us ask for guidance from the developers of this kernel
module. Our current configuration is the following ...

OS: Ubuntu 18.04, Linux du108-r2145-3 4.4.0-142-generic #168 SMP Wed
Jul 24 18:19:09 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
Motherboard: Intel S1200SPL
CPUs: Intel(R) Xeon(R) CPU E3-1230 v6 @ 3.50GHz or Intel(R) Xeon(R)
CPU E3-1270 v5 @ 3.60GHz

We see the following kernel modules are loaded. From our understanding
though, there is no method to get this ko to operate in interrupt mode
instead of polling. We desire interrupt mode. we are open to kernel
patches or moving the kernel to a later version to get this critical
EDAC feature to function on systems that utilize the following

root@du108-r2145-3:~# modinfo ie31200_edac
filename:
/lib/modules/4.4.0-142-generic/kernel/drivers/edac/ie31200_edac.ko
description:    MC support for Intel Processor E31200 memory hub controllers
author:         Jason Baron <jbaron@akamai.com>
license:        GPL
srcversion:     340329DA0015F03633253D0
alias:          pci:v00008086d00005918sv*sd*bc*sc*i*
alias:          pci:v00008086d00001918sv*sd*bc*sc*i*
alias:          pci:v00008086d00000C08sv*sd*bc*sc*i*
alias:          pci:v00008086d00000C04sv*sd*bc*sc*i*
alias:          pci:v00008086d0000015Csv*sd*bc*sc*i*
alias:          pci:v00008086d00000158sv*sd*bc*sc*i*
alias:          pci:v00008086d00000150sv*sd*bc*sc*i*
alias:          pci:v00008086d0000010Csv*sd*bc*sc*i*
alias:          pci:v00008086d00000108sv*sd*bc*sc*i*
depends:        edac_core
retpoline:      Y
intree:         Y
vermagic:       4.4.0-142-generic SMP mod_unload modversions retpoline
signat:         PKCS#7
signer:
sig_key:
sig_hashalgo:   md4
root@du108-r2145-3:~# modinfo edac_core
filename:       /lib/modules/4.4.0-142-generic/kernel/drivers/edac/edac_core.ko
description:    Core library routines for EDAC reporting
author:         Doug Thompson www.softwarebitmaker.com, et al
license:        GPL
srcversion:     60FF3CE149817D76BF414C7
depends:
retpoline:      Y
intree:         Y
vermagic:       4.4.0-142-generic SMP mod_unload modversions retpoline
signat:         PKCS#7
signer:
sig_key:
sig_hashalgo:   md4
parm:           check_pci_errors:Check for PCI bus parity errors:
0=off 1=on (int)
parm:           edac_pci_panic_on_pe:Panic on PCI Bus Parity error:
0=off 1=on (int)
parm:           edac_mc_panic_on_ue:Panic on uncorrected error: 0=off 1=on (int)
parm:           edac_mc_log_ue:Log uncorrectable error to console:
0=off 1=on (int)
parm:           edac_mc_log_ce:Log correctable error to console: 0=off
1=on (int)
parm:           edac_mc_poll_msec:Polling period in milliseconds
root@du108-r2145-3:~# uname -ra
Linux du108-r2145-3 4.4.0-142-generic #168 SMP Wed Jul 24 18:19:09 UTC
2019 x86_64 x86_64 x86_64 GNU/Linux

For example, I can boot on kernel 4.15, and see that the kernel module
is loaded as such. But, am unsure if the driver is in interrupt mode
and able to react to a UECC error occuring.
root@qkiosk:~# modinfo ie31200_edac
filename:
/lib/modules/4.15.0-46-generic/kernel/drivers/edac/ie31200_edac.ko
description:    MC support for Intel Processor E31200 memory hub controllers
author:         Jason Baron <jbaron@akamai.com>
license:        GPL
srcversion:     39D6D5F1A63B6CF65CF5F51
alias:          pci:v00008086d00005918sv*sd*bc*sc*i*
alias:          pci:v00008086d00001918sv*sd*bc*sc*i*
alias:          pci:v00008086d00000C08sv*sd*bc*sc*i*
alias:          pci:v00008086d00000C04sv*sd*bc*sc*i*
alias:          pci:v00008086d0000015Csv*sd*bc*sc*i*
alias:          pci:v00008086d00000158sv*sd*bc*sc*i*
alias:          pci:v00008086d00000150sv*sd*bc*sc*i*
alias:          pci:v00008086d0000010Csv*sd*bc*sc*i*
alias:          pci:v00008086d00000108sv*sd*bc*sc*i*
depends:
retpoline:      Y
intree:         Y
name:           ie31200_edac
vermagic:       4.15.0-46-generic SMP mod_unload
signat:         PKCS#7
signer:
sig_key:
sig_hashalgo:   md4

Respectfully,
   Dan P.
