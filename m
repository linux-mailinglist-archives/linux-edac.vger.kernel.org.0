Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BAC1410F1
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 19:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAQSkr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Jan 2020 13:40:47 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:37919 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQSkq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Jan 2020 13:40:46 -0500
Received: by mail-pl1-f178.google.com with SMTP id f20so10194589plj.5
        for <linux-edac@vger.kernel.org>; Fri, 17 Jan 2020 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=37VhHEnLonN3VBsLsaexRstzJMU5ZwdhXQzpJqxZdAA=;
        b=YTeCeDAD0If4aSccR5cTds2h0Yofh+0CNZ4E7wDWzSQkKcMRd/QWfXzRdg1IS42f7V
         m0EBXwyXXQo8s7bIMsXlTdYoWIG7GLhk96dUC2bDfP65JZhCgT1ygmmwWI8bLdUQyNCT
         ZRTqSzUjekwxPx4cRXeokBf/YCMMc0yRHZGeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=37VhHEnLonN3VBsLsaexRstzJMU5ZwdhXQzpJqxZdAA=;
        b=OCdgXmn5WvjEDq+JjGJQN7YkYHyw6/GDaL9OEXbZaJk3BExcShjeDYFOaPD7JE02Lw
         8jnf0otwbsiBSpmTBNzerqPJk0wxux2xhy0F6LXaB56qF31ebCsTt42DnWE4N7Kvawp6
         op+3aeW9V/48aEtQey6npvv++/HBj9VCBUFYqUUjz1keMplaz2twfRcnQ/MpUZChObQo
         P1qTxVjznoUqBqqSwvruFQu899eh3pE+8gysctRQ7+dQr8KbI+A2zdcSTVMByLBOdlOk
         Y4px5KZjLP+iADHWiIARkE5fyyL+6itUh6QODgqpu3sQsOiklPW+GMGTkm0kx6wniVap
         8oug==
X-Gm-Message-State: APjAAAXMEQr0hgU9ZqGcGzVs33a4rjrS1swZlkf8STVhWsdPmlglt68q
        pcCKmGrHY63fgsiP8GP66W4V6w==
X-Google-Smtp-Source: APXvYqz+czzaPdAmyGQUR55S9FX37E6K9gEke+j/f0s3Lhfqy3SMOuqamUcKKsfBRMHOdguyuYNe+A==
X-Received: by 2002:a17:90a:3763:: with SMTP id u90mr7340800pjb.107.1579286445966;
        Fri, 17 Jan 2020 10:40:45 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a9sm29830335pfn.38.2020.01.17.10.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 10:40:45 -0800 (PST)
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
To:     Shiping Ji <shiping.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, shji@microsoft.com,
        ruizhao@microsoft.com, Yuqing Shen <yuqing.shen@broadcom.com>,
        ray.jui@broadcom.com, wangglei@gmail.com
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
 <20200117001843.GJ27148@zn.tnic>
 <d5989a4c-8173-2f03-7d20-6fdd32d19591@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <1577ee39-2587-4d61-bbfc-a043e201c15a@broadcom.com>
Date:   Fri, 17 Jan 2020 10:40:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d5989a4c-8173-2f03-7d20-6fdd32d19591@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2020-01-17 10:31 a.m., Shiping Ji wrote:
>
>>> +		if (irq >= 0) {
>>> +			ret = devm_request_irq(&pdev->dev, irq,
>>> +							dmc520_isr, IRQF_SHARED,
>>> +							dev_name(&pdev->dev), mci);
>> Align arguments on the opening brace.
> I'm not sure how this can be done perfectly with tabs only :)
tabs are used first, followed by however may spaces (less than 8) needed 
to lineup at the end.
>
> All other comments have been addressed in the next patch, many thanks!
>

