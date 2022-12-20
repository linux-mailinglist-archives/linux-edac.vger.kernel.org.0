Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FA651E1C
	for <lists+linux-edac@lfdr.de>; Tue, 20 Dec 2022 10:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiLTJzt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Dec 2022 04:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiLTJys (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 20 Dec 2022 04:54:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5238F1A220
        for <linux-edac@vger.kernel.org>; Tue, 20 Dec 2022 01:52:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so11565733pjj.4
        for <linux-edac@vger.kernel.org>; Tue, 20 Dec 2022 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1sqN6s64DKmqX1n8+pEPeL7f/ccChvue6Aarj0Kqbo=;
        b=Ua5TLwTLrhXAmRSe17hmpe4tnygG9EOqZG6jLeeviASHUZkorxg5FIqn3CSxjJ4Ycx
         nsSXKUwiZCn2U8zqBEeZFPHgIfp0H5gNySiDViiuekBDfo+ImkPG7eE1q7mxBn+k9aPW
         FEWnjtw3htnw5Od+9kzkgLbS+JgM6jviA2nxaY3HFnia1hE6LAbxciZQGHQZok+sRjv2
         WQWragYZ3hnPj0YZ1xYiEzgFFhLxBJxMRtM2PaMb3TEK7fx5H0H+60WlheRYiulGdGuv
         sfq3U05Z6i1kbUNFKSqgLASlIyiR14LHV5S+SYtzlobgCKDzitfTFmK2LZngumgQ3NHC
         MkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1sqN6s64DKmqX1n8+pEPeL7f/ccChvue6Aarj0Kqbo=;
        b=gLO5gXUtHo71Rdvo+PwHqG7S7u6Lg6gLBlVGccdpSIFgm37aFI1rS3FtgxbV0kJ9yq
         wpYZojgCvrxPYZFh9RfIIaAa1Bsc/w3Etgaj3EZf02Xwf9kZVErNCc++rowuDHO8wEhH
         239kqaBKubgIgKu5Pslx3n7VdZaS9siM1pql8+z02doSl3jYZfJ8g99SJVklIg33PgPQ
         2mnAVP/nq9xBgOsEdde9GWXRg8KjI2TY2+xsDyiiBMrv71qLBvQkKkjWkssfXKIdCqEe
         H6UnUAGIwPvl0o/DJuYjoBr1SHlacun0awzj5EJ1/kByjMZN7g1/R+Ke6yNufvNW00Nh
         SYOg==
X-Gm-Message-State: AFqh2kpHLR0rxzHA4pcj/e3A6Efznc3H72O6/kra9r1CMZk/wIRXTSkE
        lmgPCrJW+BzQs3hFvlDzTNf4
X-Google-Smtp-Source: AMrXdXtmqt8YlfWPVesarE4ixcOEv2JovpIYF49omWQXDoYQSZ+LOG9P6rMWs+aQyRUCdOhmIjKJ8g==
X-Received: by 2002:a05:6a20:8f21:b0:af:88d2:33f8 with SMTP id b33-20020a056a208f2100b000af88d233f8mr19370358pzk.7.1671529938744;
        Tue, 20 Dec 2022 01:52:18 -0800 (PST)
Received: from thinkpad ([117.217.181.222])
        by smtp.gmail.com with ESMTPSA id y5-20020a623205000000b00575448ab0e9sm8141421pfy.123.2022.12.20.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:52:17 -0800 (PST)
Date:   Tue, 20 Dec 2022 15:22:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v3 06/15] arm64: dts: qcom: sc8280xp: Fix the base
 addresses of LLCC banks
Message-ID: <20221220095207.GA38609@thinkpad>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
 <20221219182958.476231-7-manivannan.sadhasivam@linaro.org>
 <CAKXuJqgL5GsyjaNpkeMf4=72sjw+6ytFUm+yt1WjLyoFLrgm3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXuJqgL5GsyjaNpkeMf4=72sjw+6ytFUm+yt1WjLyoFLrgm3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Steev,

On Mon, Dec 19, 2022 at 10:56:22PM -0600, Steev Klimaszewski wrote:
> On Mon, Dec 19, 2022 at 12:31 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > The LLCC block has several banks each with a different base address
> > and holes in between. So it is not a correct approach to cover these
> > banks with a single offset/size. Instead, the individual bank's base
> > address needs to be specified in devicetree with the exact size.
> >
> > Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 109c9d2b684d..0510a5d510e7 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -1856,8 +1856,14 @@ opp-6 {
> >
> >                 system-cache-controller@9200000 {
> >                         compatible = "qcom,sc8280xp-llcc";
> > -                       reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
> > -                       reg-names = "llcc_base", "llcc_broadcast_base";
> > +                       reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
> > +                             <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
> > +                             <0 0x09400000 0 0x58000>, <0 0x09480000 0 0x58000>,
> > +                             <0 0x09500000 0 0x58000>, <0 0x09580000 0 0x58000>,
> > +                             <0 0x09600000 0 0x58000>;
> > +                       reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
> > +                                   "llcc3_base", "llcc4_base", "llcc5_base",
> > +                                   "llcc6_base", "llcc7_base",  "llcc_broadcast_base";
> >                         interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
> >                 };
> >
> > --
> > 2.25.1
> >
> Hi Mani,
> 
> Replying on this one, because I tested v3 on the Thinkpad X13s here...
> The module probes fine, and like Andrew I see it loading...
> 
> But there still seem to be some issues...
> 
> I installed edac-utils, and I had to edit /etc/default/edac to
> actually tell it to use the qcom_edac module, since it could not
> figure this out on its own.
> Restarting the edac service, seemed to go okay, but *stopping* it,
> which unloads the module (though restarting did the same thing, so I'm
> not sure why it succeeded the first time and not the second) and we
> get:
> 

Thanks for testing the series and reporting the issue.

This is a genuine use-after-free bug that happens because the edac core frees
the memory assigned to "llcc_driv_data" pointer that gets passed as "pvt_info".

Here, the LLCC driver is one creating the "qcom_llcc_edac" platform device and
also allocating memory for "llcc_driv_data". But since during qcom_edac driver
removal, we are just unregistering the driver and the platform device still
stays around, the edac driver is not supposed to free any memory associated
with the platform device.

So the fix is to not pass "llcc_driv_data" as the "pvt_info" but instead use
the "dev->platform_data" throughout the qcom_edac driver for referencing to
"llcc_driv_data".

I added a patch locally and with that, I can remove and add the driver multiple
times without any issues. I also verified the change using KASAN.

I will add this patch to v4. Please test and report back :)

Thanks once again!

-Mani

> [ 8470.972150] EDAC MC: Removed device 0 for qcom_llcc_edac llcc: DEV
> qcom_llcc_edac
> [ 8471.047124] EDAC DEVICE1: Giving out device to module
> qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
> [ 8477.005625] EDAC MC: Removed device 1 for qcom_llcc_edac llcc: DEV
> qcom_llcc_edac
> [ 8477.005659] ------------[ cut here ]------------
> [ 8477.005661] kernel BUG at mm/slub.c:435!
> [ 8477.005668] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> [ 8477.005674] Modules linked in: qcom_edac(-) aes_ce_ccm michael_mic
> snd_soc_wsa883x q6prm_clocks q6apm_lpass_dais snd_q6dsp_common
> q6apm_dai q6prm qrtr_mhi snd_seq_dummy snd_hrtimer snd_seq
> snd_seq_device nls_ascii nls_cp437 vfat fat sg snd_q6apm qrtr_smd
> pm8941_pwrkey overlay aes_ce_blk aes_ce_cipher ghash_ce gf128mul
> sha2_ce qcom_spmi_adc_tm5 qcom_spmi_adc5 sha256_arm64 qcom_vadc_common
> qcom_pon sha1_ce snd_soc_wcd938x qcom_spmi_temp_alarm regmap_sdw
> ath11k_pci snd_soc_sc8280xp snd_soc_wcd938x_sdw industrialio
> snd_soc_hdmi_codec ath11k snd_soc_qcom_common snd_soc_wcd_mbhc
> mac80211 snd_soc_lpass_rx_macro snd_soc_lpass_va_macro
> snd_soc_lpass_tx_macro soundwire_qcom snd_soc_lpass_macro_common
> snd_soc_lpass_wsa_macro libarc4 snd_soc_core snd_compress
> soundwire_bus snd_pcm_dmaengine cfg80211 snd_pcm qcom_q6v5_pas mhi
> qcom_pil_info qcom_q6v5 snd_timer qcom_sysmon snd qcom_common slimbus
> soundcore qcom_rng qcom_battmgr joydev hid_multitouch evdev
> binfmt_misc fuse configfs ip_tables x_tables
> [ 8477.005791] autofs4 ext4 mbcache jbd2 uas msm mdt_loader ocmem
> gpu_sched llcc_qcom gpio_keys qrtr [last unloaded: qcom_edac]
> [ 8477.005814] CPU: 7 PID: 3215 Comm: modprobe Not tainted
> 6.1.0-next-20221219 #25
> [ 8477.005818] Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS
> N3HET74W (1.46 ) 10/12/2022
> [ 8477.005822] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 8477.005826] pc : __slab_free+0x118/0x550
> [ 8477.005839] lr : __slab_free+0x48/0x550
> [ 8477.005847] sp : ffff80000ca1ba70
> [ 8477.005849] x29: ffff80000ca1ba70 x28: ffff1b0bc0002200 x27: 0000000000000000
> [ 8477.005855] x26: 0000000000e46b07 x25: 0000000000000000 x24: ffff1b133bf3e800
> [ 8477.005862] x23: 000000000020001f x22: ffff1b133bf3e800 x21: ffffaf4f127f0470
> [ 8477.005867] x20: ffff1b133bf3e800 x19: fffffc6c4cefcf80 x18: ffffffffffffffff
> [ 8477.005873] x17: 63636c6c5f6d6f63 x16: ffffaf4f127ee274 x15: 636c6c2063616465
> [ 8477.005878] x14: 0000000000000004 x13: ffff1b0bc0271810 x12: 0000000000000000
> [ 8477.005884] x11: ffff1b0bfe2d2720 x10: ffff1b0bfe2d26c8 x9 : ffffaf4f120cda00
> [ 8477.005889] x8 : ffff80000ca1bb40 x7 : 0000000000000000 x6 : 0000000000000000
> [ 8477.005894] x5 : ffffaf4f127f0470 x4 : 0000000000000000 x3 : ffff1b133bf3e840
> [ 8477.005899] x2 : ffffffffffffffc0 x1 : 0000000000000000 x0 : 0000000000000040
> [ 8477.005905] Call trace:
> [ 8477.005907] __slab_free+0x118/0x550
> [ 8477.005914] __kmem_cache_free+0x290/0x2b4
> [ 8477.005918] kfree+0x8c/0x174
> [ 8477.005925] edac_device_ctrl_master_release+0x30/0x60
> [ 8477.005933] kobject_put+0xb0/0x220
> [ 8477.005940] edac_device_unregister_sysfs_main_kobj+0x1c/0x30
> [ 8477.005944] edac_device_free_ctl_info+0x18/0x2c
> [ 8477.005950] qcom_llcc_edac_remove+0x2c/0x40 [qcom_edac]
> [ 8477.005962] platform_remove+0x30/0x64
> [ 8477.005969] device_remove+0x54/0x8c
> [ 8477.005973] device_release_driver_internal+0x1ec/0x260
> [ 8477.005978] driver_detach+0x58/0xa0
> [ 8477.005983] bus_remove_driver+0x64/0x100
> [ 8477.005988] driver_unregister+0x38/0x70
> [ 8477.005993] platform_driver_unregister+0x1c/0x30
> [ 8477.005998] qcom_llcc_edac_driver_exit+0x18/0x918 [qcom_edac]
> [ 8477.006007] __arm64_sys_delete_module+0x1c0/0x340
> [ 8477.006014] invoke_syscall+0x50/0x120
> [ 8477.006021] el0_svc_common.constprop.0+0x4c/0xf4
> [ 8477.006026] do_el0_svc+0x40/0xbc
> [ 8477.006032] el0_svc+0x2c/0x84
> [ 8477.006038] el0t_64_sync_handler+0xf4/0x120
> [ 8477.006043] el0t_64_sync+0x190/0x194
> [ 8477.006049] Code: b9402b80 8b000283 eb1402df 54fffb01 (d4210000)
> [ 8477.006053] ---[ end trace 0000000000000000 ]---
> [ 8477.006056] note: modprobe[3215] exited with preempt_count 1
> [ 8477.006282] ------------[ cut here ]------------
> [ 8477.006285] WARNING: CPU: 7 PID: 0 at kernel/context_tracking.c:128
> ct_kernel_exit.constprop.0+0xe0/0xf0
> [ 8477.006294] Modules linked in: qcom_edac(-) aes_ce_ccm michael_mic
> snd_soc_wsa883x q6prm_clocks q6apm_lpass_dais snd_q6dsp_common
> q6apm_dai q6prm qrtr_mhi snd_seq_dummy snd_hrtimer snd_seq
> snd_seq_device nls_ascii nls_cp437 vfat fat sg snd_q6apm qrtr_smd
> pm8941_pwrkey overlay aes_ce_blk aes_ce_cipher ghash_ce gf128mul
> sha2_ce qcom_spmi_adc_tm5 qcom_spmi_adc5 sha256_arm64 qcom_vadc_common
> qcom_pon sha1_ce snd_soc_wcd938x qcom_spmi_temp_alarm regmap_sdw
> ath11k_pci snd_soc_sc8280xp snd_soc_wcd938x_sdw industrialio
> snd_soc_hdmi_codec ath11k snd_soc_qcom_common snd_soc_wcd_mbhc
> mac80211 snd_soc_lpass_rx_macro snd_soc_lpass_va_macro
> snd_soc_lpass_tx_macro soundwire_qcom snd_soc_lpass_macro_common
> snd_soc_lpass_wsa_macro libarc4 snd_soc_core snd_compress
> soundwire_bus snd_pcm_dmaengine cfg80211 snd_pcm qcom_q6v5_pas mhi
> qcom_pil_info qcom_q6v5 snd_timer qcom_sysmon snd qcom_common slimbus
> soundcore qcom_rng qcom_battmgr joydev hid_multitouch evdev
> binfmt_misc fuse configfs ip_tables x_tables
> [ 8477.006378] autofs4 ext4 mbcache jbd2 uas msm mdt_loader ocmem
> gpu_sched llcc_qcom gpio_keys qrtr [last unloaded: qcom_edac]
> [ 8477.006395] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G D
> 6.1.0-next-20221219 #25
> [ 8477.006399] Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS
> N3HET74W (1.46 ) 10/12/2022
> [ 8477.006401] pstate: 204003c5 (nzCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 8477.006405] pc : ct_kernel_exit.constprop.0+0xe0/0xf0
> [ 8477.006411] lr : ct_kernel_exit.constprop.0+0x48/0xf0
> [ 8477.006417] sp : ffff800008253d50
> [ 8477.006419] x29: ffff800008253d50 x28: 0000000000000000 x27: 0000000000000000
> [ 8477.006424] x26: 0000000000000000 x25: 0000000000000000 x24: 000007b5b4f2b289
> [ 8477.006430] x23: 0000000000000000 x22: ffff1b133bd4deb0 x21: ffffaf4f138ce178
> [ 8477.006435] x20: ffffaf4f130c6940 x19: ffffaf4f1339eeb0 x18: ffff1b0bc9725a0c
> [ 8477.006440] x17: 3430303030303030 x16: ffff1b0bc9725b00 x15: ffff80000ca1b5d8
> [ 8477.006446] x14: 0000ffffee58afff x13: ffffffffffffffff x12: ffffaf4f138c9bb0
> [ 8477.006451] x11: 0000000000000001 x10: 0000000000000b80 x9 : ffffaf4f12806da8
> [ 8477.006457] x8 : ffff1b0bc03a3be0 x7 : 0000000000000004 x6 : 00000013d6932dd5
> [ 8477.006462] x5 : 00ffffffffffffff x4 : 0000000000000001 x3 : ffffaf4f1338f008
> [ 8477.006467] x2 : ffff6bc4289af000 x1 : 4000000000000002 x0 : 4000000000000000
> [ 8477.006473] Call trace:
> [ 8477.006475] ct_kernel_exit.constprop.0+0xe0/0xf0
> [ 8477.006481] ct_idle_enter+0x10/0x20
> [ 8477.006487] cpuidle_enter_state+0x244/0x4e0
> [ 8477.006493] cpuidle_enter+0x40/0x60
> [ 8477.006498] do_idle+0x234/0x2c0
> [ 8477.006504] cpu_startup_entry+0x2c/0x3c
> [ 8477.006509] secondary_start_kernel+0x128/0x150
> [ 8477.006514] __secondary_switched+0xb0/0xb4
> [ 8477.006520] ---[ end trace 0000000000000000 ]---
> 
> I'm not entirely sure it's this driver, but removing the module can
> reliably reproduce it.
> --steev

-- 
மணிவண்ணன் சதாசிவம்
