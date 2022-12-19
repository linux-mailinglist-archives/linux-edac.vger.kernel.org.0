Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4BD651205
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 19:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiLSSdP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 13:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiLSScR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 13:32:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D0625A
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id js9so9980333pjb.2
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PVnQKP7oNdrUNmwohJQk3GAbsbyZ21YPYiaFQu000f4=;
        b=G/+XUPGwLp4EY9GJTIJ8CZfZqL3jcqF3dfYYNADdbI/Z/D5n1AbUVw9Nz7xyfEbmsA
         IqOJ+bb/z2uKeJ16gUU3414VtvaJO3ZPASd98YyaLF9eIj/6XibZ4B1BQ3qizle5qesU
         HTCo7ZNPlcf0JhJlKxKiNJlEBixO+iICov0iPIwrjihQ+DLCr0mQUAiN8boV0Man8VCy
         DoQek06wu84yf1HO/KyUNIJg0dVWVz/i9Mw+tCuB8utNIZ8FSmgZWEGIE/S2vnQT3LrS
         7d+GWoLtvDz+zNOc83SauTASVmI7ZMILygCQMSwsQKyKq9UXD8sqKQ2Gv3Q5vx5xpEih
         PoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVnQKP7oNdrUNmwohJQk3GAbsbyZ21YPYiaFQu000f4=;
        b=IjWHWjfBqJ4/NcxJVNSTqa3vEVlGdwi0Sex6i0hpzs9K6YQx2sgnS/D0tAiQ38eR9u
         I9PR8v3YlANZvZWepoVn3coogypIsOUKWi528zEhEmGTH/5KrHCqvVW1mibJ72sbIGnC
         zBRbRMvALT3cJIGctQCRMRf5n681ZEf/wwqnM7DCrhY+lYqGM2VmSRhPskuok8RSpb+O
         5mX/8i7mZeqXXN/xWGsxspelxz9hMF/D+xq/log52qLV22jQoposTFs+gi6Wy6HrW6wK
         2A5nU9al3uYGH2bpvK1B2/rFaTScf/I120H+ER8CCoOVTz1KttwMzfeXj4Veol37Bjrj
         Cujg==
X-Gm-Message-State: ANoB5pkbptDs57JQATA3gMyI93XXV+benLKebZJs+/ovA8noivxZg2We
        baHRFTXy8BUDcifjqedK//6STcMD6+hLAY8=
X-Google-Smtp-Source: AA0mqf7D0YYD7XtD4fAx0uFKGN9VoO5NrYy0CawXxr9ighchqco9whyjw2bwcxPCuhbiOVr5XK0fUQ==
X-Received: by 2002:a17:90a:ea09:b0:219:8d8a:a608 with SMTP id w9-20020a17090aea0900b002198d8aa608mr45517417pjy.43.1671474690043;
        Mon, 19 Dec 2022 10:31:30 -0800 (PST)
Received: from thinkpad ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id ds6-20020a17090b08c600b00218f9bd50c7sm6223719pjb.50.2022.12.19.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:31:29 -0800 (PST)
Date:   Tue, 20 Dec 2022 00:01:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com
Subject: Re: [PATCH v2 00/13] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221219183122.GD126558@thinkpad>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Andrew,

On Mon, Dec 12, 2022 at 01:23:40PM -0600, Andrew Halaney wrote:
> On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
> > The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> > accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> > This offset only works for some SoCs like SDM845 for which driver support
> > was initially added.
> >
> > But the later SoCs use different register stride that vary between the
> > banks with holes in-between. So it is not possible to use a single register
> > stride for accessing the CSRs of each bank. By doing so could result in a
> > crash with the current drivers. So far this crash is not reported since
> > EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> > driver extensively by triggering the EDAC IRQ (that's where each bank
> > CSRs are accessed).
> >
> > For fixing this issue, let's obtain the base address of each LLCC bank from
> > devicetree and get rid of the fixed stride.
> >
> > This series affects multiple platforms but I have only tested this on
> > SM8250 and SM8450. Testing on other platforms is welcomed.
> >
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> 

I dropped your tested-by tag in v3 as some of the patch content have been
changed. Please test v3 and share your feedback.

Thanks,
Mani

> I took this for a quick spin on the qdrive3 I've got access to without
> any issue:
> 
>     [root@localhost ~]# modprobe qcom_edac
>     [root@localhost ~]# dmesg | grep -i edac
>     [    0.620723] EDAC MC: Ver: 3.0.0
>     [    1.165417] ghes_edac: GHES probing device list is empty
>     [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
>     [root@localhost ~]# cat /proc/interrupts | grep ecc
>     174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
>     [root@localhost ~]#
> 
> Potentially stupid question, but are users expected to manually load the
> driver as I did? I don't see how it would be loaded automatically in the
> current state, but thought it was funny that I needed to modprobe
> myself.
> 
> Please let me know if you want me to do any more further testing!
> 
> Thanks,
> Andrew
> 

-- 
மணிவண்ணன் சதாசிவம்
