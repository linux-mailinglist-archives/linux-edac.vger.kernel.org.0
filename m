Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FC713CF6B
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 22:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgAOVt7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 16:49:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46794 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgAOVt6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Jan 2020 16:49:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so8803613pgb.13;
        Wed, 15 Jan 2020 13:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LLDRRS4nV7uStiCF7NJijm364cVs1q2+kbVX1Zspg38=;
        b=a4tXtc1MsCd/AAzWT05JSh0STp4V5v5W99JdSxxo99mNSaIXM1by4ESzPtCgimSYtf
         yc3f8FEAN+rUJOHgIEy+DQS+Sa4utJG00V1IOHvECTDTK7skX4jRZ/OUhe/01+hF5Ixe
         lyeKKaoWQsvpmJ2VTwm/3aNFoihGj47IMsTWE/ZIFD05lm8Ci2/5aTKCFsZ8eM/BAyCs
         Fu30t4D1017WOfYNAKXPw8iJjteKzY2JdnKAXAOMn5As4QOqq8ydLQNIqMp1tmTObzuX
         LOHRSeigSiOYXWKbXxFrcQ8yJDx2FHyo0M1CxfEqKNdWl+ZWBR9hzi+Sq5VKxYiTak9f
         gSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LLDRRS4nV7uStiCF7NJijm364cVs1q2+kbVX1Zspg38=;
        b=rgqIw+iH1DtTp9ZVxkSJcf3vMaiS8SA//n1KlZ1H9X6CqblbHGvNVNnWlCSVkTImyn
         iWWNHNSuqhTJAnyltLnJPVPTwh5IN8cxocrsGIQ7NP1vF83DxfE+P9gq42B7PMgmp2NJ
         ZjnyZc6OPkn9xH6fkc9xJlZsNoSk6HGwNhV2woKADdGa5vqSvPJkm+mynVftxb6H5lpI
         bhoaO3kkcVUF0xci/T0ThYcQ28kfXrBNgoct28ptzN/nMb9Y5g4egrsUpTHTPt9n8dyj
         /LixlCggYTO++ND8h9yhw1nV2ERr3pH5PTRh29YT1x06XgvMit0DP7CbvzpgOBv9rXIt
         oR+A==
X-Gm-Message-State: APjAAAXU7IFk4/Jf/oEP0qUqOEmQ2G1oQX3AlEAeqD6+jF15ADoKYtq/
        fGJ/8BNKLNV75/QPxdmc9E8=
X-Google-Smtp-Source: APXvYqw4tFFtqVWsYBb0+omdhX/b6+0lKkDeJt8gEEiG7Cy/SI84NzstJLCZb3wIXZ0ERZYaEEflqw==
X-Received: by 2002:a65:6815:: with SMTP id l21mr34166607pgt.283.1579124998023;
        Wed, 15 Jan 2020 13:49:58 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:acd4:5c73:b928:d080? ([2001:4898:80e8:f:2cdd:5c73:b928:d080])
        by smtp.gmail.com with ESMTPSA id b65sm22584179pgc.18.2020.01.15.13.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 13:49:57 -0800 (PST)
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
To:     Borislav Petkov <bp@alien8.de>, sashal@kernel.org
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hangl@microsoft.com, Lei Wang <lewan@microsoft.com>,
        shji@microsoft.com, ruizhao@microsoft.com,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
 <20200115213848.GO20975@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <3f1f28fd-2abf-2e1c-ef46-1992058b7a1a@gmail.com>
Date:   Wed, 15 Jan 2020 13:49:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115213848.GO20975@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/15/2020 1:38 PM, Borislav Petkov wrote:
> On Wed, Jan 15, 2020 at 06:32:33AM -0800, Shiping Ji wrote:
>> New driver supports error detection and correction on the devices with ARM
>> DMC-520 memory controller.
>>
>> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
>> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
> 
> This mail still has your From: because I guess you pasted the patch in
> the mail.
> 
> But, if you look at what I wrote here:
> 
> https://lkml.kernel.org/r/20200107195606.GM29542@zn.tnic
> 
> you'll see the
> 
> From: Lei Wang <leiwang_git@outlook.com>
> 
> which is the last From: in the mail and that is taken by git as the
> author of the patch.
> 
> However, if I apply this mail of yours, it will make you the
> author. Because in git there can be only one author per patch
> and other authors can be additionally accredited with the
> Co-developed-by: tag from the same doc I was pointing at before:
> Documentation/process/submitting-patches.rst
>
> Looking at this driver, however, you have supplied three authors. And I
> think you guys need to discuss it amongst yourselves who is going to be
> the author of this driver in the git history.

Lei will be the author of this driver in the git history. I could ask her to send the patch again if that's the correct way to go. Please confirm.
 
> If there are more questions, I'm pretty sure Sasha would be glad to
> explain to you how the whole authorship thing works and what the
> implications are.

Thanks, Sasha is currently OOF until April 19th. 

--
Best regards,
Shiping Ji
