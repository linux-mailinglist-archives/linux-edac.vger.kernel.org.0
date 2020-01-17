Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9A1410B8
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgAQSYM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Jan 2020 13:24:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43330 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAQSYM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Jan 2020 13:24:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so12309629pfo.10;
        Fri, 17 Jan 2020 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZq4930H9HujJy04y88tu8oZfEIDfkU1+0+vk4EgxTk=;
        b=NG/bBZ9xt5g9xcqgnyHR4u+N+LkBsrI+BB+q+EzgjQFYNsPWuGmYkwmAWpvfFhxU3G
         hdQMFqfOLdO3y3NvlwAQaic7RwMAhfIf/Ar1LAeJOjxvB1UhpEDNYR2mkek1zAEqa5cR
         c6mzvmoG0Xl4rncgYPfA3xyx1YxZnckNwJbCL2ommLHjUfLYxL1TPdbjiaK/I2S7CctC
         NvbTyHnpS7U5XIhdI3+4cV9y4ePt/CPHDqCHhcVaxSbwPeLQUJqFR/vcZzUQG0O15ddP
         g41Nv3n9k4dFlpPuPK5RdAhYWSiKtMQBtJIJlBGDJi5jzQqeriLfjO+D5sSV+ixV8Q5D
         JO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZq4930H9HujJy04y88tu8oZfEIDfkU1+0+vk4EgxTk=;
        b=afralLiHjqmzN8qSILru28pepTnCIffwDE4OAhW00RbBY1b3Ry1o5dph7Xd+8PJ6DX
         F4CXo6xnjp56z9Ljo4sGNsW+CMMFmDoNXjtljH0aR6tEl4C30+vH8s9LYBneeQ0JkLOi
         KeWucy53zJ+uEDwmNFSzbRjlmFbSo7orc56VYQGHcNNoPdXdbW/py3e9EknirZPI4lFd
         t/4gRDpwwpMRO3MAHIv9YVrQFfZ2eRq7Pm1ZSdlLb0OSQo8xfzefJvsEUY48oO1Pp4+3
         WEUUA5vRK1XgJMH8ZTADmG+oBeEIaPBav3xX6qyDkE1e8OfZR65kZjf+zEdS4vSpTH2p
         uHQg==
X-Gm-Message-State: APjAAAXjxqnggnXkVkjlLok7v71gMU78p7TCJhNhwcI1KW4f5nr6pwc4
        oJwWkVR9jr0I3q5GyFSwkdc=
X-Google-Smtp-Source: APXvYqwqwtjiy/0ADuAQYaj/8wr83Ow+Ynf/qWks0ep1fuSe0WQLg9Hb44mfoLAT+0d/JXjA/BTNug==
X-Received: by 2002:a63:fc57:: with SMTP id r23mr45446402pgk.71.1579285451964;
        Fri, 17 Jan 2020 10:24:11 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:a811:24b6:1823:a6d9? ([2001:4898:80e8:8:2821:24b6:1823:a6d9])
        by smtp.gmail.com with ESMTPSA id s18sm30103344pfh.179.2020.01.17.10.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 10:24:11 -0800 (PST)
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
To:     Scott Branden <scott.branden@broadcom.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, shji@microsoft.com,
        ruizhao@microsoft.com, Yuqing Shen <yuqing.shen@broadcom.com>,
        ray.jui@broadcom.com, wangglei@gmail.com
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
 <aa80b8a5-5297-91c6-6410-99e43b53bd20@broadcom.com>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <d05f6394-e076-6c99-965a-28444c0f24f9@gmail.com>
Date:   Fri, 17 Jan 2020 10:24:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <aa80b8a5-5297-91c6-6410-99e43b53bd20@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/16/2020 4:31 PM, Scott Branden wrote:
> Hi Shiping,
> 
> Here is another small change to cleanup.
>> +    } else {
>> +        memset(info, 0, sizeof(struct ecc_error_info));
> This should be sizeof(*info), not sizeof(struct ecc_error_info)
> for better programming to allow info to change type in the future
> without the code changing.

Yes, two occurrences will be replaced in the next patch, thanks!

-- 
Best regards,
Shiping Ji
