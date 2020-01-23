Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E89146EA7
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAWQre (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 11:47:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43594 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAWQrd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Jan 2020 11:47:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so1639534pgc.10;
        Thu, 23 Jan 2020 08:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BnpsU6StHPAIstw2JpFgpCJVlQcTQuWju7U53QdQrnE=;
        b=Fr/exgfHRSXeszkt7vWrJOJ2Sw6g4HEa60n79E5aaUrt2D0zH2kfcXLFqICWsIkP5D
         oRLAm1xSKgGmjiJRhHXMuegRtQjWKeLbgTItkAbxAwOAIAqT01xhXE6TJrd+lD7Gb1Qh
         zlQzNJqTpuk7YODsJHjQRvJkPCjskaxSdiklkNq3MHY1QrIY+fE1naLNaspl7L6q70qD
         0iJwLjy0+NfIXYXXyEyQGytMxG2A+TQuuTbh8oWhfi6U40S+0OX1v2cYtCYEi50BxkDs
         sPP7VvBVMZLcMDMf3gX3t5rMzqRX8JjXBi7MbpuIV47/6VDhP2atBOcpsLoqfbAs528b
         Yvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnpsU6StHPAIstw2JpFgpCJVlQcTQuWju7U53QdQrnE=;
        b=ei5R/39zXl8HKDTZdQEEDhfFn0MSFV83uRpbWuwdvxhtSR+GJX8oFq30q6VxIlw6Cf
         w3tJkWYk95q0cFeuoTlqlFub2cHf1xgi794f/GVhq7QvUzmhGF6u6kmFnIvI1vu9KkdY
         DXv55EFow6WqP5Ypit23vk78FjjF60Uxls8jy6Taf3kkzCnk4D+OuBcahdWjGWoCe9Vg
         PZzQ7j7jXlFimHq7HhZsAD7iEup1vVEgDXEIp1DwtPmEXu+QR5EKa0D4PrsNQThzbRHD
         xcJ5/pbElgomT5I1dVij2h7dnY4nXGLBDsjJCADMDA8YsJyhTfhtxM+31Ic+xjWJKG/g
         24Fg==
X-Gm-Message-State: APjAAAUDqBgJGRyTuX482fWw6OGTRX7Sj+HXmte8aGUNtsw1jXhA04eV
        n7nBJO07vhnGx7oi6qoeqmc=
X-Google-Smtp-Source: APXvYqyzFRPW1W5MSOcz5elsS1/zgpJTEP1GHlsITj9vbpwWAg1eKE9Kf6/CCL4dmRPBHY1JfBp41g==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr8259716pfi.131.1579798052959;
        Thu, 23 Jan 2020 08:47:32 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:140e:bf9b:65a6:dd72? ([2001:4898:80e8:8:941d:bf9b:65a6:dd72])
        by smtp.gmail.com with ESMTPSA id d4sm3421232pjz.12.2020.01.23.08.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 08:47:32 -0800 (PST)
Subject: Re: [PATCH v10 1/2] dt-bindings: edac: dmc-520.yaml
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
References: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
 <20200123082322.GB10328@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <4165bb52-6dda-60e9-c248-428822167476@gmail.com>
Date:   Thu, 23 Jan 2020 08:47:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123082322.GB10328@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/23/2020 12:23 AM, Borislav Petkov wrote:
> On Wed, Jan 22, 2020 at 04:31:07PM -0800, Shiping Ji wrote:
>> This is the device tree bindings for new EDAC driver dmc520_edac.c.
>>
>> From: Lei Wang <leiwang_git@outlook.com>
>>
>> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
>> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
>>
>> ---
>>      Changes in v10:
>>          - Convert to the YAML format for binding description
> 
> So you've changed this patch considerably. If you do so, you cannot keep
> Reviewed-by tags.
> 
> Also, AFAICT, you've written a completely *new* patch which would mean
> that this time you're the author. Correct?
> 
> If so, you don't need to keep Lei's From.

Boris, we'd still like to keep her as the author since this patch is just updating to a new documentation format where the content being documented was still designed by Lei. I hope this is OK.

> In any case, please take some time to read this:
> 
> https://www.kernel.org/doc/html/latest/process/index.html
> 
> It is a lot so do concentrate on the whole process, i.e., this:
> 
> https://www.kernel.org/doc/html/latest/process/development-process.html
> 
> so that you have a basic idea.
> 
> If you have questions, I'm sure Sasha would be willing to answer them
> even if he's away now.

Thanks! I'll certainly read this.

-- 
Best regards,
Shiping Ji
