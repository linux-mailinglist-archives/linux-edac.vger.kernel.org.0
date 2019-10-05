Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1CCCB7E
	for <lists+linux-edac@lfdr.de>; Sat,  5 Oct 2019 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfJEQw2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 5 Oct 2019 12:52:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35259 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfJEQw2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 5 Oct 2019 12:52:28 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so20203201iop.2
        for <linux-edac@vger.kernel.org>; Sat, 05 Oct 2019 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uky6JpDFU+CZECGAEs0U7YGA76HwcFeWeWPNZF7kk3M=;
        b=mMzFdxZfA3kwwN3LqS0jfObVxSJQ9Azse7Z3U3xLtdZEdWmxwhwxzQNaI7s6WUgUQl
         75fivdUWe9lJXY11bdRghEYhLM4HKOOlLEkwaDVCAnAuijaYmScwgZjC7+Ura/aKjGPS
         xSuO9Sm2IryuNPpVgQ/q1Y0S1jga0kUzVXNTtZ4Ca0IqFKE3ZCtSGd5QpJcCf+gqiiHW
         dNuqpNBGWwDkzsDawIKIEBmrTTOeMlXMKl/B8pmWpLZ+/2zCoSKdndyOvL6MV8pNXtAf
         I7xJQWLRQMPZlcQc4COJE3LjkFMlPMUsveH2X5Q6VbpIntHp+xNHWngge+W1AhOZKyVg
         GObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uky6JpDFU+CZECGAEs0U7YGA76HwcFeWeWPNZF7kk3M=;
        b=j1wyMmMVP3qnlFQmmgZxFB/ebdWj4GsBCXFEf0Fk1Qa9f3a3jvbm9qehnY44b94yXa
         0NKWKeXeVna87nu76ogVSKKsqBMFO5QswZmyCSFVFMi26LvodMzKc75Q35NjUAETshVX
         QJyKMA/CDT5IlFnftxnZudPBlMugOLM92AjJ1CGchU6hHJk6xwP3p3/YuKecuz2WPP35
         rpiu/bvHzG09+aBPcsPPmQRIGcincgbxBZ+27jjuf/oBMIz1B8Bi93SlLg73O1rcSCxe
         qsWaeE7ZX1I5ADGmlXLKznNC7AbGPQEZ0i7x4aicZ5Bwao0cYZZ3PWm+Ysm/2myRRo/Y
         cQiw==
X-Gm-Message-State: APjAAAVoJhAT4IMuON+xeHn3uTeTd8YAA0wuf2gEpLpQcmvoC9vZoxfC
        BtPq98EGm4zwlHBKsD1QHwT720gvZp+LbgvyYVoY2A==
X-Google-Smtp-Source: APXvYqzntZ/X3VsDRO5+RsVBr0TRjZDuPVKukrhpgSJLmGxU75TuO1u5AgFzVtYbfVD6YqV83GQkd9lMnErENT8TY+M=
X-Received: by 2002:a92:98d3:: with SMTP id a80mr22310004ill.167.1570294346232;
 Sat, 05 Oct 2019 09:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic>
In-Reply-To: <20190924092644.GC19317@zn.tnic>
From:   Jeff God <jfgaudreault@gmail.com>
Date:   Sat, 5 Oct 2019 12:52:15 -0400
Message-ID: <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi, and thanks a lot for the quick response.

So I waited for the 5.4 rc1 to be out and downloaded the tar.gz from
kernel.org to be sure and build this new version to test the new EDAC
for AMD fam 17h model 7xh:
* To test it, I used the mce inject module
* Only the flag "sw" reported anything in dmesg,  here is the output:
[  371.111818] mce: Machine check injector initialized
[  696.292223] mce: [Hardware Error]: Machine check events logged
[  696.292225] [Hardware Error]: Corrected error, no action required.
[  696.292229] [Hardware Error]: CPU:0 (17:71:0)
MC0_STATUS[-|CE|-|-|-|-|-|-|-|-]: 0x0000000000000000
[  696.292232] [Hardware Error]: IPID: 0x0000000000000000
[  696.292234] [Hardware Error]: Load Store Unit Ext. Error Code: 0,
Load queue parity error.
[  696.292236] [Hardware Error]: cache level: RESV, tx: INSN
* I tried different addr values that I believe are in valid range, all
other values (cpu,...) were left to their default (0), I used bank 0
to trigger the tests and tried different values briefly but always
with the same results
* Any other flag did not log any error or message anywhere (I mostly
focused on the "hw" one which I believe is a proper hardware error
injection that simulate the ecc)
* During these tests I monitored both dmesg and edac-util -rfull.
* edac-util always reported/showed 0 error
* I haven't done any memory overclocking this time with and without
ecc to properly assess the ecc as I do normally since it takes more
time and I relied on the assumption that mce-inject with hw flag
should first work and report errors, but it doesn't

Please let me know if there is something I should have done
differently with mce inject to test.

Just to recap, in summary my observations so far based on my tests is
that I can get the EDAC driver to load now (it was also the case with
my previous attempts by changing the pci devices ids with my own
kernel builds of 5.3), but it does not seem EDAC ever report any ce
(or ue) ecc error even when they may be happening and corrected in
background. So I was wondering if others had seen the same thing on
their systems with these new CPUs or if it was really confirmed to
report errors when they happen.

Here are the high level specs of the system used, for reference:
* CPU AMD Ryzen 3900x (fam 17h model 71h)
* Memory modules: KINGSTON KSM26ED8/16ME (4x16GB == 64GB)
* Motherboard: ASUS PRIME X570-PRO (BIOS 1201)

Here is the dmesg output related to the edac driver messages after
startup (in debug):

[    0.000000] Command line: initrd=\elementary\initrd.img
root=UUID=c51491ea-900f-4a3e-997c-8b37cbc675ee ro  quiet splash kaslr
mitigations=off clocksource=tsc tsc=reliable igb.EEE=0
edac_debug_level=666
[    0.000000] Kernel command line: initrd=\elementary\initrd.img
root=UUID=c51491ea-900f-4a3e-997c-8b37cbc675ee ro  quiet splash kaslr
mitigations=off clocksource=tsc tsc=reliable igb.EEE=0
edac_debug_level=666
[    0.178120] EDAC MC: Ver: 3.0.0
[    0.178120] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    9.914600] EDAC DEBUG: compute_num_umcs: Number of UMCs: 2
[    9.914606] EDAC amd64: Node 0: DRAM ECC enabled.
[    9.914607] EDAC amd64: F17h_M70h detected (node 0).
[    9.914613] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    9.914613] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    9.914614] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    9.914614] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000e0000000
[    9.914615] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000001020000000
[    9.914628] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001
reg: 0x50000
[    9.914629] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    9.914631] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000201
reg: 0x50004
[    9.914632] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    9.914634] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000401
reg: 0x50008
[    9.914635] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    9.914637] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000601
reg: 0x5000c
[    9.914638] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    9.914640] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x07fff9fe
reg: 0x50020
[    9.914642] EDAC DEBUG: read_umc_base_mask:
DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    9.914643] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x07fff9fe
reg: 0x50024
[    9.914644] EDAC DEBUG: read_umc_base_mask:
DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    9.914646] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001
reg: 0x150000
[    9.914647] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    9.914649] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000201
reg: 0x150004
[    9.914650] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    9.914652] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000401
reg: 0x150008
[    9.914653] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    9.914655] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000601
reg: 0x15000c
[    9.914656] EDAC DEBUG: read_umc_base_mask:
DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    9.914658] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x07fff9fe
reg: 0x150020
[    9.914659] EDAC DEBUG: read_umc_base_mask:
DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    9.914661] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x07fff9fe
reg: 0x150024
[    9.914663] EDAC DEBUG: read_umc_base_mask:
DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    9.914663] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    9.914664] EDAC DEBUG: __dump_misc_regs_df: UMC0 DIMM cfg: 0x1
[    9.914664] EDAC DEBUG: __dump_misc_regs_df: UMC0 UMC cfg: 0x80001200
[    9.914665] EDAC DEBUG: __dump_misc_regs_df: UMC0 SDP ctrl: 0xb040808b
[    9.914665] EDAC DEBUG: __dump_misc_regs_df: UMC0 ECC ctrl: 0x671
[    9.914667] EDAC DEBUG: __dump_misc_regs_df: UMC0 ECC bad symbol: 0x0
[    9.914668] EDAC DEBUG: __dump_misc_regs_df: UMC0 UMC cap: 0x10030
[    9.914668] EDAC DEBUG: __dump_misc_regs_df: UMC0 UMC cap high: 0x40000000
[    9.914669] EDAC DEBUG: __dump_misc_regs_df: UMC0 ECC capable: yes,
ChipKill ECC capable: no
[    9.914670] EDAC DEBUG: __dump_misc_regs_df: UMC0 All DIMMs support ECC: yes
[    9.914670] EDAC DEBUG: __dump_misc_regs_df: UMC0 x4 DIMMs present: no
[    9.914670] EDAC DEBUG: __dump_misc_regs_df: UMC0 x16 DIMMs present: no
[    9.914671] EDAC MC: UMC0 chip selects:
[    9.914671] EDAC DEBUG: f17_addr_mask_to_cs_size: CS0 DIMM0 AddrMasks:
[    9.914672] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914672] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914673] EDAC DEBUG: f17_addr_mask_to_cs_size: CS1 DIMM0 AddrMasks:
[    9.914673] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914674] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914674] EDAC amd64: MC: 0:  8192MB 1:  8192MB
[    9.914675] EDAC DEBUG: f17_addr_mask_to_cs_size: CS2 DIMM1 AddrMasks:
[    9.914675] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914676] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914676] EDAC DEBUG: f17_addr_mask_to_cs_size: CS3 DIMM1 AddrMasks:
[    9.914676] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914677] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914677] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    9.914678] EDAC DEBUG: __dump_misc_regs_df: UMC1 DIMM cfg: 0x1
[    9.914678] EDAC DEBUG: __dump_misc_regs_df: UMC1 UMC cfg: 0x80001200
[    9.914679] EDAC DEBUG: __dump_misc_regs_df: UMC1 SDP ctrl: 0xb040808b
[    9.914679] EDAC DEBUG: __dump_misc_regs_df: UMC1 ECC ctrl: 0x671
[    9.914681] EDAC DEBUG: __dump_misc_regs_df: UMC1 ECC bad symbol: 0x0
[    9.914682] EDAC DEBUG: __dump_misc_regs_df: UMC1 UMC cap: 0x10030
[    9.914682] EDAC DEBUG: __dump_misc_regs_df: UMC1 UMC cap high: 0x40000000
[    9.914683] EDAC DEBUG: __dump_misc_regs_df: UMC1 ECC capable: yes,
ChipKill ECC capable: no
[    9.914683] EDAC DEBUG: __dump_misc_regs_df: UMC1 All DIMMs support ECC: yes
[    9.914684] EDAC DEBUG: __dump_misc_regs_df: UMC1 x4 DIMMs present: no
[    9.914684] EDAC DEBUG: __dump_misc_regs_df: UMC1 x16 DIMMs present: no
[    9.914684] EDAC MC: UMC1 chip selects:
[    9.914685] EDAC DEBUG: f17_addr_mask_to_cs_size: CS0 DIMM0 AddrMasks:
[    9.914685] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914686] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914686] EDAC DEBUG: f17_addr_mask_to_cs_size: CS1 DIMM0 AddrMasks:
[    9.914686] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914687] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914687] EDAC amd64: MC: 0:  8192MB 1:  8192MB
[    9.914688] EDAC DEBUG: f17_addr_mask_to_cs_size: CS2 DIMM1 AddrMasks:
[    9.914688] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914688] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914689] EDAC DEBUG: f17_addr_mask_to_cs_size: CS3 DIMM1 AddrMasks:
[    9.914689] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914689] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914690] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    9.914690] EDAC DEBUG: __dump_misc_regs_df: F0x104 (DRAM Hole
Address): 0xe0000001, base: 0xe0000000
[    9.914691] EDAC DEBUG: dump_misc_regs:   DramHoleValid: yes
[    9.914691] EDAC amd64: using x16 syndromes.
[    9.914691] EDAC amd64: MCT channel count: 2
[    9.914693] EDAC DEBUG: edac_mc_alloc: allocating 1896 bytes for
mci data (8 ranks, 8 csrows/channels)
[    9.914698] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 0
[    9.914699] EDAC DEBUG: f17_addr_mask_to_cs_size: CS0 DIMM0 AddrMasks:
[    9.914699] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914700] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914700] EDAC DEBUG: get_csrow_nr_pages: csrow: 0, channel: 0, DBAM idx: 3
[    9.914701] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914701] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 1
[    9.914702] EDAC DEBUG: f17_addr_mask_to_cs_size: CS1 DIMM0 AddrMasks:
[    9.914702] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914702] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914703] EDAC DEBUG: get_csrow_nr_pages: csrow: 1, channel: 0, DBAM idx: 3
[    9.914703] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914704] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 2
[    9.914704] EDAC DEBUG: f17_addr_mask_to_cs_size: CS2 DIMM1 AddrMasks:
[    9.914704] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914705] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914705] EDAC DEBUG: get_csrow_nr_pages: csrow: 2, channel: 0, DBAM idx: 3
[    9.914706] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914706] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 3
[    9.914706] EDAC DEBUG: f17_addr_mask_to_cs_size: CS3 DIMM1 AddrMasks:
[    9.914707] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914707] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914708] EDAC DEBUG: get_csrow_nr_pages: csrow: 3, channel: 0, DBAM idx: 3
[    9.914708] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914709] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 0
[    9.914709] EDAC DEBUG: f17_addr_mask_to_cs_size: CS0 DIMM0 AddrMasks:
[    9.914709] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914710] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914710] EDAC DEBUG: get_csrow_nr_pages: csrow: 0, channel: 1, DBAM idx: 3
[    9.914711] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914711] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 1
[    9.914711] EDAC DEBUG: f17_addr_mask_to_cs_size: CS1 DIMM0 AddrMasks:
[    9.914712] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914712] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914713] EDAC DEBUG: get_csrow_nr_pages: csrow: 1, channel: 1, DBAM idx: 3
[    9.914713] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914713] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 2
[    9.914714] EDAC DEBUG: f17_addr_mask_to_cs_size: CS2 DIMM1 AddrMasks:
[    9.914714] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914715] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914715] EDAC DEBUG: get_csrow_nr_pages: csrow: 2, channel: 1, DBAM idx: 3
[    9.914715] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914716] EDAC DEBUG: init_csrows_df: MC node: 0, csrow: 3
[    9.914716] EDAC DEBUG: f17_addr_mask_to_cs_size: CS3 DIMM1 AddrMasks:
[    9.914717] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original
AddrMask: 0x7fff9fe
[    9.914717] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved
AddrMask: 0x1fffffe
[    9.914717] EDAC DEBUG: get_csrow_nr_pages: csrow: 3, channel: 1, DBAM idx: 3
[    9.914718] EDAC DEBUG: get_csrow_nr_pages: nr_pages/channel: 2097152
[    9.914718] EDAC DEBUG: edac_mc_add_mc_with_groups:
[    9.914736] EDAC DEBUG: edac_create_sysfs_mci_device: device mc0 created
[    9.914743] EDAC DEBUG: edac_create_dimm_object: device rank0
created at location csrow 0 channel 0
[    9.914750] EDAC DEBUG: edac_create_dimm_object: device rank1
created at location csrow 0 channel 1
[    9.914756] EDAC DEBUG: edac_create_dimm_object: device rank2
created at location csrow 1 channel 0
[    9.914762] EDAC DEBUG: edac_create_dimm_object: device rank3
created at location csrow 1 channel 1
[    9.914768] EDAC DEBUG: edac_create_dimm_object: device rank4
created at location csrow 2 channel 0
[    9.914774] EDAC DEBUG: edac_create_dimm_object: device rank5
created at location csrow 2 channel 1
[    9.914780] EDAC DEBUG: edac_create_dimm_object: device rank6
created at location csrow 3 channel 0
[    9.914786] EDAC DEBUG: edac_create_dimm_object: device rank7
created at location csrow 3 channel 1
[    9.914793] EDAC DEBUG: edac_create_csrow_object: device csrow0 created
[    9.914800] EDAC DEBUG: edac_create_csrow_object: device csrow1 created
[    9.914806] EDAC DEBUG: edac_create_csrow_object: device csrow2 created
[    9.914813] EDAC DEBUG: edac_create_csrow_object: device csrow3 created
[    9.914821] EDAC MC0: Giving out device to module amd64_edac
controller F17h_M70h: DEV 0000:00:18.3 (INTERRUPT)
[    9.914822] EDAC DEBUG: edac_pci_alloc_ctl_info:
[    9.914823] EDAC DEBUG: edac_pci_add_device:
[    9.914824] EDAC DEBUG: add_edac_pci_to_global_list:
[    9.914824] EDAC DEBUG: find_edac_pci_by_dev:
[    9.914825] EDAC DEBUG: edac_pci_create_sysfs: idx=0
[    9.914825] EDAC DEBUG: edac_pci_main_kobj_setup:
[    9.914828] EDAC DEBUG: edac_pci_main_kobj_setup: Registered
'.../edac/pci' kobject
[    9.914828] EDAC DEBUG: edac_pci_create_instance_kobj:
[    9.914830] EDAC DEBUG: edac_pci_create_instance_kobj: Register
instance 'pci0' kobject
[    9.914831] EDAC PCI0: Giving out device to module amd64_edac
controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
[    9.914832] AMD64 EDAC driver v3.5.0

Best Regards,
Jean-Frederic


On Tue, 24 Sep 2019 at 05:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Sep 23, 2019 at 07:30:11PM -0400, Jeff God wrote:
> > Has anyone tested the new edac implementation and confirmed that error
> > reporting (CE and UE) are actually working for AMD family 17h model 70h?
>
> Please add linux-edac@vger.kernel.org to CC in the reply of this mail,
> which is the EDAC mailing list. We can continue the discussion there.
>
> > I am asking because I have build and implemented previously my own "basic"
> > support for a ryzen 3900x using the kernel sources before this was pushed
> > by simply adding the different PCI devices IDs and edac appeared to have
> > loaded properly and detected all ECC modules (visible in dmesg)
>
> This all should be unnecessary with 5.4-rc1. Try it when it comes out
> next week as it should have all the bits needed. If not, the above ML is
> for reporting issues.
>
> > However, I did my best to try to generate ECC errors (I am not too familiar
> > with the debugging method to inject and not sure how reliable it is) by
>
> See below. There's an mce-inject module and when loaded, it creates a
> bunch of files in debugfs with which you can inject errors. Help README
> is below.
>
> > overclocking (stock voltages) the memory to a point the system is barely
> > stable and never got any CE or UE error reporting after several hours/days.
> > I used mprime to generate errors with large memory amounts (54GB on 64GB
> > system), and when I turn OFF the ECC in the bios, mprime reports memory
> > errors using its internal check under 10 minutes after starting a torture
> > test (reproduced several times), but when ECC is turned ON, it does not
> > show any error as if everything was stable. This made me conclude that ECC
> > is working and at least some CE errors are most likely happening but are
> > hidden since the edac-util -rfull always reported 0 error.
>
> You'd have to send dmesg with 5.4-rc1 once it is out. Then we can have a
> look.
>
> HTH.
>
> $ cat /sys/kernel/debug/mce-inject/README
> Description of the files and their usages:
>
> Note1: i refers to the bank number below.
> Note2: See respective BKDGs for the exact bit definitions of the files below
> as they mirror the hardware registers.
>
> status:  Set MCi_STATUS: the bits in that MSR control the error type and
>          attributes of the error which caused the MCE.
>
> misc:    Set MCi_MISC: provide auxiliary info about the error. It is mostly
>          used for error thresholding purposes and its validity is indicated by
>          MCi_STATUS[MiscV].
>
> synd:    Set MCi_SYND: provide syndrome info about the error. Only valid on
>          Scalable MCA systems, and its validity is indicated by MCi_STATUS[SyndV].
>
> addr:    Error address value to be written to MCi_ADDR. Log address information
>          associated with the error.
>
> cpu:     The CPU to inject the error on.
>
> bank:    Specify the bank you want to inject the error into: the number of
>          banks in a processor varies and is family/model-specific, therefore, the
>          supplied value is sanity-checked. Setting the bank value also triggers the
>          injection.
>
> flags:   Injection type to be performed. Writing to this file will trigger a
>          real machine check, an APIC interrupt or invoke the error decoder routines
>          for AMD processors.
>
>          Allowed error injection types:
>           - "sw": Software error injection. Decode error to a human-readable
>             format only. Safe to use.
>           - "hw": Hardware error injection. Causes the #MC exception handler to
>             handle the error. Be warned: might cause system panic if MCi_STATUS[PCC]
>             is set. Therefore, consider setting (debugfs_mountpoint)/mce/fake_panic
>             before injecting.
>           - "df": Trigger APIC interrupt for Deferred error. Causes deferred
>             error APIC interrupt handler to handle the error if the feature is
>             is present in hardware.
>           - "th": Trigger APIC interrupt for Threshold errors. Causes threshold
>             APIC interrupt handler to handle the error.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
