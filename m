Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE953D03D5
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 01:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfJHXId (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 19:08:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38914 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfJHXIc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Oct 2019 19:08:32 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so730986ioc.6
        for <linux-edac@vger.kernel.org>; Tue, 08 Oct 2019 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6aFUtMwsTFbOnj1SQwERjU/j/hMw/6FuOwB92sBrNk=;
        b=IjKqZThjUPk4TMdz3q1IMFbTH9+sARGO+zfPI/yGAliYU2iUhs0Q1X+rWDy3uZpt81
         4qxJOm+fykM/ttlu5yR/aq9uZqxxoRmUEA1a3RcCgRL0uG7ZVfHuGJrgiQd5hJdg7n3u
         UybpV+wlj/x3K/w/hNdHPyMP1iGx9x+X1tfAaeYCv6Jq3/ldf73WoP5MhMwCTeFh788Q
         eDe4yehLfstBFZiO/uqwiSvyFhtxp5s6dRzx4TducpHN0DiN6MPhETsp+qPZj8NOSev5
         QaxuiI6XT21lBYzl8v79VYe7kuH9J7vmw6Ceer9YyFj0UdbfvtIgJO65ZM/C5DMPHzpA
         u+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6aFUtMwsTFbOnj1SQwERjU/j/hMw/6FuOwB92sBrNk=;
        b=FKOaqMQKdexEDjAJffNhHPrtKY86+JMD+0nI4Y3W85uj94UIbLcvz4ty4DAjTLVIuL
         BnavitTJFmiPpm8vgbcM8h5lkLBodAVKOnz87rbgp/ddW/zAaejDu1LRVV07qz+TP5Oo
         J8f09cVgUrTBU6pHudMPYsRcAU4evkWnpCyyO3XFhLu+5KGYwzUzBiNmoXQTmcPz59sB
         hdDJvyawHBgfQjAsT+2A4wHnG+AYfgy8LKhT9jKA/AU7J9JaGCuHJGwfkLvRnNkQJW2d
         oI4M1kJq/eA6c6EskrLShOSdAJyFvTzBaz5Ln3sx8mC7qbd5wJxjHmvSJoUektgi1006
         fg2w==
X-Gm-Message-State: APjAAAWiqIXk1KCESaTPL0vQBeLga/0W+OM1MYMT/UCcbdozwtwXRl8b
        YCzu0ByubNiW5XNXdDCJhm8kVZpiKg7gl1W7LXwod8/a
X-Google-Smtp-Source: APXvYqy0mQx8dTlHzFIF5KYVXh67+iNGvjvJskiU9gtBr+K7DkyJi7YVgZI9jNloikdWa/NYko9rzk2zT8FZ8MSla0A=
X-Received: by 2002:a02:497:: with SMTP id 145mr511124jab.10.1570576111190;
 Tue, 08 Oct 2019 16:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic> <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic> <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic> <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
In-Reply-To: <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
From:   Jeff God <jfgaudreault@gmail.com>
Date:   Tue, 8 Oct 2019 19:08:20 -0400
Message-ID: <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 8 Oct 2019 at 15:42, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>
> The "hw" option requires a non-zero, valid MCA_STATUS to be used so that the
> MCA handlers will find the error in the hardware and report it.
>
> Jean-Frederic,
> You originally had status=0 which explains why nothing was reported.
>
> Boris,
> You used non-zero values, but you targetted bank 4. This bank is
> Read-as-Zero/Writes-Ignored on Family 17h and later. So even though you used
> good values, the MCA handlers won't find anything because bank 4 is RAZ.
>
>
> Here are some values I took from a real corrected DRAM ECC error.
>
> status=0x9c2041000000011b
> synd=0x7c7600010a800100
>
> The memory controller banks are 17 (channel 0) and 18 (channel 1) on Family
> 17h Model 7Xh, and these are managed by CPU 0.
>
Thanks a lot for the explanation.

I also wanted to apologise for the text emails line wrapping, I
haven't found a viable email client alternative...

I wasn't too sure about the correct meaning of the value for the
status, but I tried the non zero values mentioned above, here is a
list of tests I did:

echo 0x9c7d410092080813 > status; echo 0x000000006d3d483b > addr; echo
0 > cpu; echo hw > flags; echo 17 > bank
echo 0x9c7d410092080813 > status; echo 0x000000006d3d483b > addr; echo
0 > cpu; echo hw > flags; echo 18 > bank
echo 0x9c2041000000011b > status; echo 0x000000006d3d483b > addr; echo
0 > cpu; echo hw > flags; echo 17 > bank
echo 0x9c2041000000011b > status; echo 0x000000006d3d483b > addr; echo
0 > cpu; echo hw > flags; echo 18 > bank

During all these tests I was checking dmesg as well as all the status
files in /sys/kernel/debug/mce-inject.
I did not see anything in dmesg, and all status files remained 0
(except flag which was hw)

If I change hw for sw, it outputs something similar to what I reported before:
[  969.570997] mce: [Hardware Error]: Machine check events logged
[  969.570998] [Hardware Error]: Corrected error, no action required.
[  969.571002] [Hardware Error]: CPU:0 (17:71:0)
MC18_STATUS[-|CE|MiscV|AddrV|-|SyndV|CECC|-|-|Scrub]:
0x9c2041000000011b
[  969.571005] [Hardware Error]: Error Addr: 0x000000006d3d483b
[  969.571006] [Hardware Error]: IPID: 0x0000000000000000, Syndrome:
0x0000000000000000
[  969.571008] [Hardware Error]: Unified Memory Controller Ext. Error
Code: 0, DRAM ECC error.

Also, sometimes with sw it seems to report more messages:
[  840.033409] mce: [Hardware Error]: Machine check events logged
[  840.033411] [Hardware Error]: Corrected error, no action required.
[  840.033414] [Hardware Error]: CPU:0 (17:71:0)
MC17_STATUS[-|CE|MiscV|AddrV|-|SyndV|CECC|-|-|Scrub]:
0x9c2041000000011b
[  840.033417] [Hardware Error]: Error Addr: 0x000000006d3d483b
[  840.033418] [Hardware Error]: IPID: 0x0000000000000000, Syndrome:
0x0000000000000000
[  840.033420] [Hardware Error]: Unified Memory Controller Ext. Error
Code: 0, DRAM ECC error.
[  840.033435] EDAC MC0: 1 CE Unknown syndrome - possible error
reporting race on mc#0csrow#0channel#0 (csrow:0 channel:0
page:0x1d4f52 offset:0x3b grain:1 syndrome:0x0)
[  840.033436] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

And even this:
[  609.681714] mce: [Hardware Error]: Machine check events logged
[  609.681716] [Hardware Error]: Corrected error, no action required.
[  609.681720] [Hardware Error]: CPU:0 (17:71:0)
MC17_STATUS[-|CE|MiscV|AddrV|-|SyndV|CECC|-|-|Scrub]:
0x9c2041000000011b
[  609.681723] [Hardware Error]: Error Addr: 0x000000006d3d483b
[  609.681724] [Hardware Error]: IPID: 0x0000000000000000, Syndrome:
0x0000000000000000
[  609.681726] [Hardware Error]: Unified Memory Controller Ext. Error
Code: 0, DRAM ECC error.
[  609.681743] ------------[ cut here ]------------
[  609.681748] WARNING: CPU: 4 PID: 2447 at
drivers/edac/edac_mc.c:1238 edac_mc_handle_error+0x5a6/0x6d0
[  609.681748] Modules linked in: mce_inject amd64_edac_mod kvm_amd
kvm irqbypass snd_hda_codec_hdmi nls_iso8859_1 joydev crct10dif_pclmul
input_leds crc32_pclmul ghash_clmulni_intel snd_hda_intel
snd_intel_nhlt snd_usb_audio snd_hda_codec uvcvideo snd_hda_core
snd_usbmidi_lib snd_hwdep videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 snd_pcm videobuf2_common videodev mc snd_seq_midi
snd_seq_midi_event aesni_intel snd_rawmidi crypto_simd cryptd
glue_helper eeepc_wmi asus_wmi snd_seq sparse_keymap mxm_wmi video
wmi_bmof snd_seq_device snd_timer snd k10temp ccp soundcore mac_hid
sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4
btrfs xor zstd_compress raid6_pq libcrc32c hid_logitech_hidpp
hid_logitech_dj uas usb_storage hid_generic usbhid hid nvme i2c_piix4
igb ahci libahci dca nvme_core i2c_algo_bit wmi
[  609.681779] CPU: 4 PID: 2447 Comm: kworker/4:2 Not tainted 5.4.0-rc1 #1
[  609.681780] Hardware name: System manufacturer System Product
Name/PRIME X570-PRO, BIOS 1201 09/09/2019
[  609.681783] Workqueue: events mce_gen_pool_process
[  609.681785] RIP: 0010:edac_mc_handle_error+0x5a6/0x6d0
[  609.681787] Code: 94 be 72 79 00 00 49 89 84 24 68 05 00 00 48 8b
45 98 85 c9 c7 40 08 6d 65 6d 6f 66 89 70 0c c6 40 0e 00 75 a8 e9 6e
fd ff ff <0f> 0b 31 c0 49 c7 84 24 90 06 00 00 01 00 00 00 e9 4b fe ff
ff 49
[  609.681788] RSP: 0018:ffffb200428e3c68 EFLAGS: 00010246
[  609.681789] RAX: 0000000000000000 RBX: ffffffff89be5882 RCX: 0000000000000001
[  609.681789] RDX: 0000000000000000 RSI: ffffffff89be5888 RDI: 0000000000000000
[  609.681790] RBP: ffffb200428e3ce8 R08: 0000000000000000 R09: ffff98a116959c6f
[  609.681791] R10: 00000000ffffffff R11: ffff98a096959c79 R12: ffff98a096959800
[  609.681791] R13: 0000000000000003 R14: ffff98a096959c7a R15: 0000000000000000
[  609.681792] FS:  0000000000000000(0000) GS:ffff98a09d900000(0000)
knlGS:0000000000000000
[  609.681793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  609.681794] CR2: 0000556dc3323730 CR3: 0000000fd3ab6000 CR4: 0000000000340ee0
[  609.681795] Call Trace:
[  609.681799]  ? pci_read_config_dword+0x23/0x40
[  609.681804]  __log_ecc_error+0x62/0x90 [amd64_edac_mod]
[  609.681807]  decode_umc_error+0xdc/0x1a0 [amd64_edac_mod]
[  609.681810]  amd_decode_mce+0xb26/0xba0
[  609.681812]  notifier_call_chain+0x4c/0x70
[  609.681814]  blocking_notifier_call_chain+0x43/0x60
[  609.681816]  mce_gen_pool_process+0x41/0x70
[  609.681818]  process_one_work+0x1fd/0x3f0
[  609.681820]  worker_thread+0x34/0x410
[  609.681821]  kthread+0x121/0x140
[  609.681822]  ? process_one_work+0x3f0/0x3f0
[  609.681823]  ? kthread_park+0x90/0x90
[  609.681826]  ret_from_fork+0x1f/0x40
[  609.681828] ---[ end trace 1dc9b9df24b597d5 ]---
[  609.681830] EDAC MC0: 1 CE Unknown syndrome - possible error
reporting race on mc#0csrow#0channel#0 (csrow:0 channel:0
page:0x1d4f52 offset:0x3b grain:1 syndrome:0x0)
[  609.681831] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

Again, all these messages showed only with sw, never with hw

Let me know if I should be doing something differently.

Regards,
Jean-Frederic
