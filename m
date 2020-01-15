Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1213C5D6
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 15:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAOOWu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 09:22:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45459 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgAOOWu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Jan 2020 09:22:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so8586495pfg.12;
        Wed, 15 Jan 2020 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b+rUvYWKoAM/J15shsDFhmjGwGV/oW2xVnsU6cgQp8c=;
        b=RXdYxl4yj15d8nM4oUNWtJTtPn4D+CVTzd1+VXlnlHPIv0eKdF1Gr6cRoFViGnuqtG
         P9Gqah8qXjt/jMz45RfbxWtipe+Yl2WuZwm+SvCSVvGYAA8ZFHod+uSeTz04J85SAGOL
         8+o2J3K7VWtzeHz+RU3mgmoxPkhCsY13bYgeZdJ1G2Lc5GXcunGNSNuMZ39fybUp+Svl
         yzDUL6kS+JGBHYaIKzEpcOqynCIz7nfZ0eW1+S/s0oueWlNvijyRhPxf5gposGQKij9C
         A1fONnnxe5CY89lkddrMZ23rlVkWJQ9qxzxBT2jCi0v6t3yLMKl4kZg9CW/7NbHBUcm3
         lmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+rUvYWKoAM/J15shsDFhmjGwGV/oW2xVnsU6cgQp8c=;
        b=reuu9udoM2AXrC8XejpFM9sn7ex1SRClst6i6H9Dx2ycer/qyK7gJCjU6T+Ka2Catg
         G8REDgRatod3CEennn0eDgTUfMMdT73dIHB4tCIW0Oo1Y8KlYHbMRvBahLNeCMTHRlbi
         dwAIY3ixvoxyAF4NnBs0+jwur3w7J2S6kkV2K9jTCZP+s9jCf16XxWYbhkGN21IGDqx0
         UX4A6GEFeJ3+dZiJVHlMkmLbKi/S+/DK92Z50AenfKm942NhYhbYmupr0o4yBAssy1Wq
         qzIxPl5HSz85xXceAnU25sNYSLw8Vk/FBtqnYNf3C8KrDIt8u6ML1R8R72pHt1GD8/2/
         nNug==
X-Gm-Message-State: APjAAAXLUSMJqvCqmOpoQIGASvjjHj1eET9vcGCqYdd6EfzMx7U5WqHh
        Hi3h8olAfiYCiAGFZMQe4X4=
X-Google-Smtp-Source: APXvYqxfSMJdPWQ1G7Dbhn47HLgrqcYRvd44//y2o3Rii8l5Ly5BE37b6smjsbCl8zU/3lMks2lF9Q==
X-Received: by 2002:a63:4c4f:: with SMTP id m15mr33194421pgl.346.1579098169273;
        Wed, 15 Jan 2020 06:22:49 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:acd4:5c73:b928:d080? ([2001:4898:80e8:9:2ce3:5c73:b928:d080])
        by smtp.gmail.com with ESMTPSA id n24sm22074736pff.12.2020.01.15.06.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 06:22:48 -0800 (PST)
Subject: Re: [PATCH v8 2/2] EDAC: add EDAC driver for DMC520
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com, shji@microsoft.com
References: <0cc7bcfe-0dee-b78a-a0fe-52cc48c00a44@gmail.com>
 <20200115124833.GE20975@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <78dc4c79-985f-32b9-c8c4-a38aeb64b49d@gmail.com>
Date:   Wed, 15 Jan 2020 06:22:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115124833.GE20975@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/15/2020 4:48 AM, Borislav Petkov wrote:
> On Tue, Jan 14, 2020 at 03:52:23PM -0800, Shiping Ji wrote:
>> New driver supports error detection and correction on the devices with ARM
>> DMC-520 memory controller.
>>
>> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
> 
> I don't think you've understood the whole SOB chain thing yet. Previous
> submissions had
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> 
> and her as author and you've completely removed those and made yourself
> an author because when I apply this patch, it would take the From:
> header from the mail and make it the author.
> 
> But you can't simply remove her authorship... you need to read that doc
> again.
> 

Sorry about it, my misunderstanding again. I'll submit a new patch shortly.

-- 
Best regards,
Shiping Ji
