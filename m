Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70D64B969
	for <lists+linux-edac@lfdr.de>; Tue, 13 Dec 2022 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiLMQSG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Dec 2022 11:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbiLMQSF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Dec 2022 11:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671821246
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 08:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670948240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1pLjNkhsq8g1Rc8hO7YGLRyBx6MQKjmBm04bPyq/9nw=;
        b=Hu+C+/X3tDcuW2iwz74LtKhaJ/GjI0IJxLR9x5pnHGSTSibMswhCbBv7wdKgNOYhZ93PW/
        /ckBluOEcvR//Hl5/RtNfdykhps46MxcVzzQ8G2VHrri731o4Hm7sF3TGJCHZ2sQ7hKmr8
        kFdedYWMxtM4KsFiraYOR/dD6/XHkJY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-205-EOcDz3_-Ob-EUI-vWkZzow-1; Tue, 13 Dec 2022 11:17:14 -0500
X-MC-Unique: EOcDz3_-Ob-EUI-vWkZzow-1
Received: by mail-oi1-f197.google.com with SMTP id a12-20020a05680804cc00b0035b9a1d20ecso127516oie.2
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 08:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pLjNkhsq8g1Rc8hO7YGLRyBx6MQKjmBm04bPyq/9nw=;
        b=Zo2kn5Wmlx1FONLDuA+Htqyey4Qh/Pu+Yik+DnGq1gOx3a15BohDT1+BQHctlmst17
         cbAuA7b3AM3b7JjR56olBWyhbcWmyqrjsrobOwSankRGvduz+Tm051KVkF00rFgsNY61
         yzEUON42iANlxsp6WpJ/4SfDjsiBNgsMl2/t+KH7SJzmgu1LTU35MJN3TMU5U82p8omD
         uCHzOSpeJ+5ia3HBDDNB9fM03pQ8Bk/36A3jds7Ye3N1t6x7kNWi9ykcFF1h1ms9Hlrn
         /+teJK+z0s7SitwtuxdCpegzVqsrKhil3psDT/XYGt4Kftkm55A22QqQZVwU2g3oGfa0
         Zllw==
X-Gm-Message-State: ANoB5pnJ+qZb28s98M/Zv2LcTftBYttJQXQzZ12nnIJbrOnkudL2TGmz
        /gM5fklqLpbLJd62QFWLDBtXsHecBeag3eQk+PBm/3QIkQJs7G9wzC5AorM58xj6OtfhxPqshEZ
        NPz4J0zYxu1ytnTM0cROlag==
X-Received: by 2002:a05:6871:6a8:b0:145:1ab:9cb8 with SMTP id l40-20020a05687106a800b0014501ab9cb8mr10993213oao.22.1670948233536;
        Tue, 13 Dec 2022 08:17:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7QM2I/vjhY/yMR47Zo+bNer5e9ledVHZ8geYgPYCI0eofFUeWEYBZbK+Cpqh/28rcMEM/KeQ==
X-Received: by 2002:a05:6871:6a8:b0:145:1ab:9cb8 with SMTP id l40-20020a05687106a800b0014501ab9cb8mr10993200oao.22.1670948233278;
        Tue, 13 Dec 2022 08:17:13 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id u7-20020a056871058700b001447a2a34dfsm1574864oan.40.2022.12.13.08.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:17:12 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:17:09 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com
Subject: Re: [PATCH v2 00/13] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221213161709.k7r4rdsfwe4pxlid@halaney-x13s>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
 <20221213052802.GB4862@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213052802.GB4862@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 13, 2022 at 10:58:02AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Dec 12, 2022 at 01:23:40PM -0600, Andrew Halaney wrote:
> > On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
> > > The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> > > accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> > > This offset only works for some SoCs like SDM845 for which driver support
> > > was initially added.
> > >
> > > But the later SoCs use different register stride that vary between the
> > > banks with holes in-between. So it is not possible to use a single register
> > > stride for accessing the CSRs of each bank. By doing so could result in a
> > > crash with the current drivers. So far this crash is not reported since
> > > EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> > > driver extensively by triggering the EDAC IRQ (that's where each bank
> > > CSRs are accessed).
> > >
> > > For fixing this issue, let's obtain the base address of each LLCC bank from
> > > devicetree and get rid of the fixed stride.
> > >
> > > This series affects multiple platforms but I have only tested this on
> > > SM8250 and SM8450. Testing on other platforms is welcomed.
> > >
> > 
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> > 
> 
> Thanks!
> 
> > I took this for a quick spin on the qdrive3 I've got access to without
> > any issue:
> > 
> >     [root@localhost ~]# modprobe qcom_edac
> >     [root@localhost ~]# dmesg | grep -i edac
> >     [    0.620723] EDAC MC: Ver: 3.0.0
> >     [    1.165417] ghes_edac: GHES probing device list is empty
> >     [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
> >     [root@localhost ~]# cat /proc/interrupts | grep ecc
> >     174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
> >     [root@localhost ~]#
> > 
> > Potentially stupid question, but are users expected to manually load the
> > driver as I did? I don't see how it would be loaded automatically in the
> > current state, but thought it was funny that I needed to modprobe
> > myself.
> > 
> > Please let me know if you want me to do any more further testing!
> > 
> 
> Well, I always ended up using the driver as a built-in. I do make it module for
> build test but never really used it as a module, so didn't catch this issue.
> 
> This is due to the module alias not exported by the qcom_edac driver. Below
> diff allows kernel to autoload it:
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index f7afb5375293..13919d01c22d 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -419,3 +419,4 @@ module_platform_driver(qcom_llcc_edac_driver);
>  
>  MODULE_DESCRIPTION("QCOM EDAC driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom_llcc_edac");
> 
> Please test and let me know. I will add this as a new patch in next version.
> 

Thanks Mani, that gets things working for me. For that patch:

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>

My personal opinion, but that probably deserves a Fixes: tag too!

