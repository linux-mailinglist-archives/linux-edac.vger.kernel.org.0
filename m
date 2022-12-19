Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D6651139
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiLSRbg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 12:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLSRbe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 12:31:34 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3D5F99
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 09:31:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a9so9696262pld.7
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 09:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/v5QF24UgCyhOviKN7va44J4qr79PiICT//51MxqP4=;
        b=toAg9I22I2g3+DhNQ5Ur2KkfYka3FHWlkU4A1A3Pq7c+MK9K6yIFq/L3jHEhSgvE59
         EbUX84zU6Wanns5WmTcEakG3gRsCjwzFvKltQEdLaBto14PyULhLCLLqTexlvKL590UI
         xsY8qiyEwU397KxaUk2EVEU/dIYGU5VbvSIg5tUxA4JoGLBG0oRBIV7MPmotPqToCIHT
         tNPTE4sPRLztaiMHCwYZKBRgJIamM/syazGjROD5GUO3rHdTnwOCGl+3HD30z1nfemRn
         A9j/inI6B7ZqCzA6MYIEEi07mZLqpA5aAXO8H5GzeqN1qWZMYx6vAX+d8pOpmpdk+nTF
         idvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/v5QF24UgCyhOviKN7va44J4qr79PiICT//51MxqP4=;
        b=uHcW3Iq9Wbyddf0aNXrxvjl0zKgNqixvNT5a1UsFvzpFYAmGHVIEwPduR9RD/pTU5F
         vgi4AKAZajHuWC2FgTAgs5cSFSAkQYHiUd54Jo0rcpL7EBPLF/WCBJwWr5Xw/lGxtatj
         M+PKeAhIAOyALwbU4JBofjTU5W4ji+/yS9C6aPe4FHwsfoi3Gh4cuvQI8iaCARolF4d7
         NCObM/3NIUHwsIlCpwXMm7ObsoXZzXW/UMJ+MawFK+aOiuGEz/s0nO+3tHM8QGbAVzdh
         MkHfEbYpEOfsp7r9geEszk+afeboYOJetNUJ0+tcOs9Iwg0Xw/tfVzt2lGP2DX19P34+
         iPVQ==
X-Gm-Message-State: ANoB5pnYW/SLnqbaK8tt7k4iDx0Sd3LvWPuaV2cp36u3gLlIyxzdSGm1
        0zPD48N3mH7hOHgVQTioqTur
X-Google-Smtp-Source: AA0mqf7tuKt4rG5/6Y1OPFfgAYiSy4D3nhTzUsNwV1AxIzrxKQlFmQQL5Bzc7zFx+DwQeGOCH27DYg==
X-Received: by 2002:a05:6a20:49a6:b0:ad:3ada:c712 with SMTP id fs38-20020a056a2049a600b000ad3adac712mr41417851pzb.14.1671471093326;
        Mon, 19 Dec 2022 09:31:33 -0800 (PST)
Received: from thinkpad ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id s11-20020a65584b000000b004771bf66781sm6512726pgr.65.2022.12.19.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:31:32 -0800 (PST)
Date:   Mon, 19 Dec 2022 23:01:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com
Subject: Re: [PATCH v2 00/13] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221219173125.GC126558@thinkpad>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
 <20221213052802.GB4862@thinkpad>
 <ec64e3a0-085d-7830-fd4e-6969c1c9bbdf@linaro.org>
 <20221213175738.GI4862@thinkpad>
 <195a55f1-76e7-3f00-da1f-4ae84f7943c0@linaro.org>
 <20221219135046.GA126558@thinkpad>
 <1df13a83-1926-05b5-f7c7-388ef431a2fa@linaro.org>
 <20221219141643.GB126558@thinkpad>
 <CAA8EJppVGAQ_OLGbsor67c4MdL4kTVL-9O+geX8AcKEjL9s92w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJppVGAQ_OLGbsor67c4MdL4kTVL-9O+geX8AcKEjL9s92w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 19, 2022 at 06:49:39PM +0200, Dmitry Baryshkov wrote:
> On Mon, 19 Dec 2022 at 16:17, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Dec 19, 2022 at 03:11:36PM +0100, Krzysztof Kozlowski wrote:
> > > On 19/12/2022 14:50, Manivannan Sadhasivam wrote:
> > > >
> > > >>> Also, the id table is
> > > >>> an overkill since there is only one driver that is making use of it. And
> > > >>> moreover, there is no definite ID to use.
> > > >>
> > > >> Every driver with a single device support has usually ID table and it's
> > > >> not a problem...
> > > >>
> > > >
> > > > Are you referring to OF/ACPI ID table? Or something else?
> > >
> > > No, I refer to the driver ID table (I2C, platform whatever the driver is).
> > >
> >
> > Yeah, that's what I wanted to avoid here. The ID table makes sense if you have
> > a bus like I2C or a separate subsystem but here LLCC is an individual driver.
> > So creating a separate ID table is an overkill IMO.
> 
> Well, struct platform_device_id is used quite a lot together with the
> MODULE_DEVICE_TABLE(platform, _ids);
> 
> On the other hand:
> 
> $ git grep MODULE_ALIAS.*platform: | wc -l
> 1308
> $ git grep MODULE_DEVICE_TABLE.*platform | wc -l
> 236
> 

Hmm. I think I will just go with platform_device_id in the next version.

Thanks,
Mani

> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
