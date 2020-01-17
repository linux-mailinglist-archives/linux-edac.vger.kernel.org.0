Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB4140077
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 01:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgAQAFu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jan 2020 19:05:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38733 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgAQAFu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Jan 2020 19:05:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so11043023pfc.5;
        Thu, 16 Jan 2020 16:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Svj12NA2gjd7b5eVHBvjZxEC8Kxi+bvZ2Dn4z/YcgvQ=;
        b=HuvuyLW5rO2BJqylPGsENctXKFexAiJ0MiShrCADJTKUgy8oAGlv1BubtJ83recXMC
         iYHx9E7cDVB2FlsjqZxmvGW4BK+kszEi4GEYM0Q8iVZqjc8cr5vkkyrs4YTp8E8Z5cTt
         HTzeW14JH6o3gg48+b8Unk/8F2eKfxr4dOgTCnK9Y6oXC0FKkvRYmnki/WmKepYMXDdi
         q3pYblq7iWlARUi8MV2Dhxg8F7NVPLLtzOd8pMrmnWSntcwtuyW4mqk7JSDTcQL16bhU
         yp9l6HiKHOHwb3QWADHQlWtnZ57DA3PS/B96zZzKU+Fg+W/4FHJ5uNnCm99Qdz/07sZU
         LhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Svj12NA2gjd7b5eVHBvjZxEC8Kxi+bvZ2Dn4z/YcgvQ=;
        b=BOmGnseJc0PcNdM8zPf8Nqb7G0ZShnhyFotqCfKtxYVIln4SdkASlVodQV4wLE86ZG
         gjocFAGuKRpsC6OoEO3g+xmQ5YjltcHJuUeNoyUl/6Mc09K1VnYKYhiT2W/S2WuDC74y
         c2mdI3Pvj2nfcRHNCy+sEAEt7/8vGJtAumnStMRsr1E5gD5cozoMetnoPA6OALMPzeCq
         79DgB2Oya5WVZ5W7eQzAnP6l6UkKdq+GgLUjHdV90ZIQKr4JrUJ12C04BMr24b4QO4k+
         5IeIBdRIXA+D+70mkx9t3lPNpPSufRQ2dZag8Hlwib7V+m2BqjW8QW41CJ+nOynLf0ft
         JUzA==
X-Gm-Message-State: APjAAAWWxDMVHveYBWXRovF4QBHem5vaya14VMmmuXn/rj0mdBEkZd5i
        +5ZiZh4p8S5ccGDM5bI3qcE=
X-Google-Smtp-Source: APXvYqxnWM+5PTjFYZHVJII74OXyuAMnX3nooi+A0jkEQ1brbqp6fqgkH9vjtMEOJD2CUvyg8B7wBQ==
X-Received: by 2002:a62:be12:: with SMTP id l18mr123364pff.226.1579219549714;
        Thu, 16 Jan 2020 16:05:49 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:cb3:a670:16e:de26? ([2001:4898:80e8:f:8cbb:a670:16e:de26])
        by smtp.gmail.com with ESMTPSA id o7sm28603861pfg.138.2020.01.16.16.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 16:05:49 -0800 (PST)
Subject: Re: [PATCH v9 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
References: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
 <20200116233939.GI27148@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <adeadf1f-df85-8af1-ccbd-fc8ff2cb4d43@gmail.com>
Date:   Thu, 16 Jan 2020 16:05:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116233939.GI27148@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/16/2020 3:39 PM, Borislav Petkov wrote:
> On Wed, Jan 15, 2020 at 06:32:27AM -0800, Shiping Ji wrote:
>> This is the device tree bindings for new EDAC driver dmc520_edac.c.
>>
>> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
>> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
> 
> So for this patch, v2 had Rui Zhao as an author:
> 
> https://lkml.kernel.org/r/BN7PR08MB5572B3388B2D7DC8F6C7F285AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com
> 
> v3 got Lei as an author:
> 
> https://lkml.kernel.org/r/CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com
> 
> and now it is you.
> 
> So when you send next time, think about who's going to be the author.

I'll make sure Lei is the author (From:) in the next patches.

>> +     line numbers. The valid interrupt names are the followings:
> 
> WARNING: 'followings' may be misspelled - perhaps 'following'?
> #51: FILE: Documentation/devicetree/bindings/edac/arm-dmc520.txt:10:
> +     line numbers. The valid interrupt names are the followings:

Yes, I think this can be fixed. I checked the scripts/spelling.txt and it does suggest using 'following' instead.
 
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense.

Yes, we will.

> Also, this patch throws this other checkpatch warning:
> 
> WARNING: DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst
> 
> but since Rob reviewed it, I'm going to assume checkpatch is wrong here.
> 
> Thx.
 
The check seems to warn the next file in .txt format which should be rather in the new .yaml format. We'll try to make one next.

Thanks!

-- 
Best regards,
Shiping Ji
