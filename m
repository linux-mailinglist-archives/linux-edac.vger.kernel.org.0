Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9264F13CFC5
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAOWIE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 17:08:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47053 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAOWIE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Jan 2020 17:08:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so8824095pgb.13;
        Wed, 15 Jan 2020 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SJWP0dc8tNu8wLgOp289sHabmbIqUoct2rH5jSqMT58=;
        b=DetHZawldPHHvcYPN8OOm8v4iwjr+CfbmF/SgvuhbeY6yzB2RxshNG003RkI5vMzRL
         FGG2xM1d+UdEEBP4xmArKkAQ337ITqERyULuI8ReUSWl11J/81t5WrMX0KWyk3Cx0xA9
         6TCnuKGuBSIUA+ONKYcLwf0LdE4Mr/wl6a82HzWbk+1YUrx5LN48Fmh9K2357BfAkqit
         2SsIIwsVuE1rI6ipVLPNlgITV2SN5Goksr/HB2txOcNa5C3gEBFbq9NAwsS6Itvyc9Ip
         R33QPOyMRe4QFugRH93Di7yJtHz6Xvfc76kCDNGX1mFuEhFl3+YUysTgwL8TRbEL6LYV
         yotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJWP0dc8tNu8wLgOp289sHabmbIqUoct2rH5jSqMT58=;
        b=ovW0PsjfLBAo4ayxXArmBROBzM8e2SZ4V94SjEbOGjuAUmRtBZk5/DrSp0LHln8CrE
         UT4knEVwuXXyG9w+XV9MTLq32zavARP7nmBrPFJ2CXXp8ANXEFPHZSUILSbcq0lKuOch
         APCOMnyq933VGdDDUy09L5b1oDX5riwVEtENXfuKmenqQwpe7BXjsZ+f7Jt5MTGxCYOH
         QMW0lT4EammXZpjeevOJ2UoOd+Le8QTzr+EvYfwDn/olzUOrxG2qeGet7wjg49CAi4nB
         OEFnxTo8SZsq6mL2SZ4E7hWtgDr9oHCD39UdrqiUkTDLBuN6Biqgnx7gJCWqwSWNektr
         beEw==
X-Gm-Message-State: APjAAAUvr4vIPn+v1iBZZpjS5SV2mHotrGYK+7OejLU2WmIgSM5yBirX
        ZdLS9DsBkD/kOAx/LN5x1wI=
X-Google-Smtp-Source: APXvYqyWsg9nZ7iS/q53dd4ttLoSRT/XWe5AeXPcI5W4HjRg03CpMwcnWHrKfBz6kd+WyBp4ymUhhg==
X-Received: by 2002:a63:2308:: with SMTP id j8mr33867384pgj.86.1579126083966;
        Wed, 15 Jan 2020 14:08:03 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:acd4:5c73:b928:d080? ([2001:4898:80e8:a:2ce2:5c73:b928:d080])
        by smtp.gmail.com with ESMTPSA id v10sm21902345pgk.24.2020.01.15.14.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 14:08:03 -0800 (PST)
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
To:     Borislav Petkov <bp@alien8.de>
Cc:     sashal@kernel.org, James Morse <james.morse@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hangl@microsoft.com, Lei Wang <lewan@microsoft.com>,
        shji@microsoft.com, ruizhao@microsoft.com,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
 <20200115213848.GO20975@zn.tnic>
 <3f1f28fd-2abf-2e1c-ef46-1992058b7a1a@gmail.com>
 <20200115220436.GP20975@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <6a27f387-2c52-6587-1b21-c2e52c1b2436@gmail.com>
Date:   Wed, 15 Jan 2020 14:08:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115220436.GP20975@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/15/2020 2:05 PM, Borislav Petkov wrote:
> On Wed, Jan 15, 2020 at 01:49:56PM -0800, Shiping Ji wrote:
>> Lei will be the author of this driver in the git history. I could ask
>> her to send the patch again if that's the correct way to go. Please
>> confirm.
> 
> No need - you only have to send the patch with her From: at the
> beginning. Btw, you make her an author in git by doing:
> 
> git commit --amend --author="Lei Wang <leiwang_git@outlook.com>"
> 
> But before you send again, let me take a look at the rest of the patch
> first, tomorrow most likely.
> 
> Thx.
> 

Got it, I will have the followings next:

From: Lei Wang <leiwang_git@outlook.com>

<commit message>

Signed-off-by: Lei Wang <leiwang_git@outlook.com>
Signed-off-by: me

--
Best regards,
Shiping Ji
