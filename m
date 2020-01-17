Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489B21410CD
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 19:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgAQSbU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Jan 2020 13:31:20 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55236 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQSbU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Jan 2020 13:31:20 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so3509656pjb.4;
        Fri, 17 Jan 2020 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8I536fgsZI1/zevVyUJAawaRzvWEK86euedntV25fzo=;
        b=TU26B/fi+c45Ik85BE26c4cduIA5MPcBVhtczQDSk8MA+5XfAwrcK/Nycl4djR5xfo
         +ywLdtk7ooCoZqLfFMElnAhBbJAxZ5lWTRjMHyilDY4buULBGysf5kJjqyuMZNEmSqjq
         L0RotQJQBFAhlUIWfsC2VS+qwmMaeQrix0tyv+4XsLFg449r+OcXx/cbKVaSAt5AQjCv
         7DUpyi9S1cekgRBBlA1fMTlSDHHvv2Al+J1YC5jvEckkTKzSs+rMGBzwgYkzX2e4YO7N
         QcRtVdHpCerXDyNxqQBKv7tjMt/ZBRP+b5mv4VvBV2SDl3aPCYyxigk69nViAUmaEITk
         9F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8I536fgsZI1/zevVyUJAawaRzvWEK86euedntV25fzo=;
        b=LjTkxRT3kbk01GLZTsqlttjLNtkyYnf+rDnzwSnJ2ckO7+udpWuC82xes4j0C/3Gyq
         2xm2lK8P5/6xLYcQU+e0EN0B1r0pSmOpVHV9vLil7UiZNySPgdGhfHmhVSYV60L4ZiSO
         7DrBLhqzIG0VcVIRhmtLUbCpNBWYWmXnCPupurkiiuqhwoE15TW+V68JGR90WoUz9dFb
         k9+xosn0ckqeKlw3LX6FU+yM92jU01zQYw3LzLt/fYaVUPUnwhuwGGgFngdBhAqoVBAB
         7AEnAnrOELZD6vrYG8VIruG1jVp5/2h14geYEv6uyeHPbukWKkV3ljZH9iS29Ivebo+l
         +zbw==
X-Gm-Message-State: APjAAAUlF/8YYdj2g+VPt0ZzT+leiCSHmFN8tQCK0Q68ev2ncbCBVAxX
        03WVms0Gva/2nYVh/MP63tc=
X-Google-Smtp-Source: APXvYqwQNLBotUtvThCp2G5pHQ8X9Ogb0cXYW6p5Yq8vsBdWs6t5kI2rZC/ismEXobuIx42s8mdKfA==
X-Received: by 2002:a17:90a:2763:: with SMTP id o90mr7048740pje.110.1579285879585;
        Fri, 17 Jan 2020 10:31:19 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:a811:24b6:1823:a6d9? ([2001:4898:80e8:2:2827:24b6:1823:a6d9])
        by smtp.gmail.com with ESMTPSA id j8sm29771828pfe.182.2020.01.17.10.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 10:31:19 -0800 (PST)
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, shji@microsoft.com,
        ruizhao@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
 <20200117001843.GJ27148@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <d5989a4c-8173-2f03-7d20-6fdd32d19591@gmail.com>
Date:   Fri, 17 Jan 2020 10:31:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117001843.GJ27148@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/16/2020 4:18 PM, Borislav Petkov wrote:

>> +/* The EDAC driver private data */
>> +struct dmc520_edac {
>> +	void __iomem *reg_base;
>> +	spinlock_t ecc_lock;
> 
> What does that spinlock protect? Also, its name is not very optimal.

This is to protect concurrent writes to the mci->error_desc as suggested by James when reviewing the patch v3.
 
>> +	reg_offset_low = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_31_00 :
>> +				 REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_31_00;
>> +	reg_offset_high = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_63_32 :
>> +				  REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_63_32;
> 
> Those define names could be shorter.

I'm trying to find a good scheme to make them shorter, at the moment they are named according to the TRM.
 
>> +		if (irq >= 0) {
>> +			ret = devm_request_irq(&pdev->dev, irq,
>> +							dmc520_isr, IRQF_SHARED,
>> +							dev_name(&pdev->dev), mci);
> 
> Align arguments on the opening brace.

I'm not sure how this can be done perfectly with tabs only :)

All other comments have been addressed in the next patch, many thanks!

-- 
Best regards,
Shiping Ji
