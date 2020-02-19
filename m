Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DEC16530B
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2020 00:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgBSX1U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Feb 2020 18:27:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44962 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgBSX1U (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Feb 2020 18:27:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id g3so884661pgs.11;
        Wed, 19 Feb 2020 15:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6JiFaz5iy9gmHgnooypOSxsxA0ut5ONuFdOKVlOwCFg=;
        b=rWVv971tZXzMCXq1FdEk/AVgIB38nVbzCRKGwYiuo/d+7G/ZfKFWWWEOdUkzQ/rcZR
         FxsuihZyd44JZAZFbtG/DgRR9Z8o66oMxnooTwsYlHEZLP3Q8zpBHhR4yNTltN2arc3g
         k7f3MD8eJ4WroZ29wX5C7DK2Wx6uWwLS7nuo4wUtMJJ+oSfGRpOZzoMLQWpwQfUxj50K
         2eYXiq49X9NpT/3abVPsfUm/mppohRwr0+jFNviQbuP70DpK+WFHSV++gGGuS7hUW1Pm
         kPUoPHkvUuOQrN1ao6/20B0UFu8VUoYlFa0+O6BNoqQYPe9CMIP08rV72XtI3MOsr+Tb
         u0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6JiFaz5iy9gmHgnooypOSxsxA0ut5ONuFdOKVlOwCFg=;
        b=tf04PCNHcxFESU3KD8K4XEjEBaulH2vysQnh5IoNq2QDsXAwii7H26GEe6+2dnIIFW
         fMMHIFACCI0BJoG/0fNp2M5NpE2aBlDJ+KDuDh0LQUithUMoPiXficGcoNRT/a7D+btE
         Cfx9Yt46T7XDOIbsOe8Y2HFA0aH4S+RfyWjLv3ShdDbAi5k7YaG5cgS9VHuUY7+6UkkJ
         7sJdZJjNP/fLTL75z9EpN4SHJs+Vvgjr/wOkoaSW8cA4mXmiK7gnO8nUN0btRff517PS
         1y+zkHIg6kJQC9yynwuBeiR2RQ4JPmA4r5e0txCbkGLar30hBphtEwtqCH1o0+2B7Pex
         9MAg==
X-Gm-Message-State: APjAAAVqx4AU9rL45BgHOMX6KMv+m3S5o+JFXfd1MmVvMm/YfQy21PSr
        2W4l74q06id2ptjXQgDX+Ro=
X-Google-Smtp-Source: APXvYqzq5to/NST8CWJIajv2bRAa9C+1cpIpDX1QKU7hisIV/jAiodj/ikTotObNse4EB9ovrbseUA==
X-Received: by 2002:aa7:8bda:: with SMTP id s26mr29656770pfd.194.1582154839975;
        Wed, 19 Feb 2020 15:27:19 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:a99d:cf29:8886:cbc? ([2001:4898:80e8:9:29ac:cf29:8886:cbc])
        by smtp.gmail.com with ESMTPSA id w189sm682332pfw.157.2020.02.19.15.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 15:27:19 -0800 (PST)
Subject: Re: [PATCH v11 1/2] dt-bindings: edac: dmc-520.yaml
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        ruizhao@microsoft.com, Lei Wang <lewan@microsoft.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
References: <5354a9c3-5b5a-486a-9d19-fa9be169faef@gmail.com>
 <20200217181055.GC14426@zn.tnic>
 <4c02326d-cf38-e1e1-1822-d24de22fa2cc@gmail.com>
 <20200219200358.GJ30966@zn.tnic>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <98d39c59-8ae0-0f7e-1bd4-3c83c1b6bee0@gmail.com>
Date:   Wed, 19 Feb 2020 15:27:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219200358.GJ30966@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2/19/2020 12:03 PM, Borislav Petkov wrote:
> On Tue, Feb 18, 2020 at 09:12:15AM -0800, Shiping Ji wrote:
>> Actually I didn't send v11 of the driver since it will be identical to v10,
>> sorry for keeping you waiting on this. Please review v10, thanks!
> 
> Ok, both patches queued and will appear in linux-next soon.
> 
> Thanks for the effort and persistence!
> 
> :-)

Thanks a lot for the prompt action! This is great learning process for me :)

--
Best regards,
Shiping Ji
