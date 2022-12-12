Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7964A812
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiLLTYk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 14:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiLLTYi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 14:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158A65B0
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 11:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670873026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSEx9zUYoMm/9QCrusKtxhc2laYdTSkOtFlDg6lImBo=;
        b=bkU0ZhMpVrq3UUk38Ld34++1R9vG5b6dXbG+qfiPZ8VTnIyHPgBqEx4B3lstaNXUk1xyPo
        Itwpa+qnaeYWtxKCnWx1OUh/6agCog9gZ46c/mkkQe7NSBNWajHLDtF44ebRI/B6OIJn8R
        m2GEe71hb43IXEKVjQIRlB1/H5r9yck=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-fAO1Kr0OMOiCPhW5Gribtw-1; Mon, 12 Dec 2022 14:23:44 -0500
X-MC-Unique: fAO1Kr0OMOiCPhW5Gribtw-1
Received: by mail-oi1-f197.google.com with SMTP id l21-20020a544115000000b0035e40187b9eso5629049oic.22
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 11:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSEx9zUYoMm/9QCrusKtxhc2laYdTSkOtFlDg6lImBo=;
        b=L4e0m8/Ys6ttsSD2MawLpqO258Nn2iEdjhfVjN/ygAHa9H6gdBJQ4wsucQDlE/hqiQ
         KEN5GWZtKPaUdgL3tA0J8ViMLjr9wq/NWGkm8XiIywaEv9KuVsvvt0mvMI36zJK2lPi/
         t8UndufOu0LCFGgCq6P6HTg3eRhnsGvIEl+jGXjBHzMBs+4vbD8rIjzgFAv5FC47Z4iG
         bpmdTM6Yn3dSYxPn7gqlE0awqmhwOli2xf5Qgt5fsCyCkdzFdGlBDfaIHRQGDWCZiazj
         nOxqlu7KjwePP5mi7qqd28wxo9NEe7t7r4XhjoMW1D6sSohjyshBu57DDVPZkZMPGKQi
         id8g==
X-Gm-Message-State: ANoB5pnVxKg/ve8pfVItKZcZznRq0Ud3Lm8ROSvJXyo/4PF+gNfVVMeM
        4Fj3aYHf62UaAecWHglkMnSiE9HK31/de2sYbSN77T7Tq1uIeRc7W9TnDA7sAwseXC3hewKtW/Q
        HiMAzZL4RMZxNjmlugeZ9Uw==
X-Received: by 2002:a05:6808:14c4:b0:35a:b52:7989 with SMTP id f4-20020a05680814c400b0035a0b527989mr9510090oiw.59.1670873024004;
        Mon, 12 Dec 2022 11:23:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5wGSx+cnOEbDpS+sjHuWp8p8Umg5ZD7jk639UhqfwqBI4NN1CgYKvj1PljWVx+KT53PxOa5w==
X-Received: by 2002:a05:6808:14c4:b0:35a:b52:7989 with SMTP id f4-20020a05680814c400b0035a0b527989mr9510068oiw.59.1670873023727;
        Mon, 12 Dec 2022 11:23:43 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id bh4-20020a056808180400b0035a81480ffcsm3861982oib.38.2022.12.12.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 11:23:43 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:23:40 -0600
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
Message-ID: <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> This offset only works for some SoCs like SDM845 for which driver support
> was initially added.
>
> But the later SoCs use different register stride that vary between the
> banks with holes in-between. So it is not possible to use a single register
> stride for accessing the CSRs of each bank. By doing so could result in a
> crash with the current drivers. So far this crash is not reported since
> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> driver extensively by triggering the EDAC IRQ (that's where each bank
> CSRs are accessed).
>
> For fixing this issue, let's obtain the base address of each LLCC bank from
> devicetree and get rid of the fixed stride.
>
> This series affects multiple platforms but I have only tested this on
> SM8250 and SM8450. Testing on other platforms is welcomed.
>

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride

I took this for a quick spin on the qdrive3 I've got access to without
any issue:

    [root@localhost ~]# modprobe qcom_edac
    [root@localhost ~]# dmesg | grep -i edac
    [    0.620723] EDAC MC: Ver: 3.0.0
    [    1.165417] ghes_edac: GHES probing device list is empty
    [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
    [root@localhost ~]# cat /proc/interrupts | grep ecc
    174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
    [root@localhost ~]#

Potentially stupid question, but are users expected to manually load the
driver as I did? I don't see how it would be loaded automatically in the
current state, but thought it was funny that I needed to modprobe
myself.

Please let me know if you want me to do any more further testing!

Thanks,
Andrew

