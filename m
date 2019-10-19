Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651A2DD998
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2019 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfJSQNB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 19 Oct 2019 12:13:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39859 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfJSQNB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 19 Oct 2019 12:13:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so8268863qki.6
        for <linux-edac@vger.kernel.org>; Sat, 19 Oct 2019 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pRxfdBaA32DFnJjLWccx6qyWkRx/1fKJh+Uefd5BBAY=;
        b=MRykaJEbom+xZ64yj38u09WWZFBC7Cv0vkRmGyzvypM+p8iGD2xiJv5Q3+7Assxvvh
         dSdpxDqm+Nu+cWF5Eb9RqzBqs8fEWvNRs1NqnsF0B+Cf6UpPf9l8I5UfkF/tPRRTOVHC
         0hMZrHlB1cq3GpCriav61UCDtVLLh42cQRrl6SeQzQWGD8OcGNW6o++1tF77358m9BgG
         h0tVAmk8q7ZrNfyvhVwMzhtGhMtVhpgmJxb9qeK5/V7oqD1PoLM26h+OrmnMmwFB35Dl
         keRasdRF8AMNN/Nndhl1J6CUrvFg5531D4YN0YhBA5CmBu17Gmut6cddwIRZQCGtPdtj
         Qf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pRxfdBaA32DFnJjLWccx6qyWkRx/1fKJh+Uefd5BBAY=;
        b=aAm4ujyigt8NuKGiu2vP37ao9yiSa6hUltzKQfIQDxwdV8rgM4oSP7AdoiIRwmqkkh
         w66g05GML0ILrrgDBi9jJrE55dPT6HCoj3XNSxhwm40+aEuPpOvgTJFvDKsmfVsyBt/R
         3ES38PEoW2Rh92XeKXt0G6aJvznuiT9w7kRDEaDBdL4XJGiH7vu13WPRXfDj73BDC7Iu
         3To+VkN+CTHrK40XWXhgw1DMXod+tdEvjczdV94d4ZuzxxLzNZUCIEldfxs6UgTUWzFp
         tx0tLXxVl0lHpm2xNon55ojtLs6k7NQLl5a0xU5pMYAZx3j8BfgCRGx4nXfbcVjYe5Xc
         ovaA==
X-Gm-Message-State: APjAAAUvasCHeCfNpxBO9sg3TRYlcwg7Q8bSnJoxFqxCdPNVKzfz3RH0
        LfcsSXdK8q1hVeygD0cNTauC3RR5
X-Google-Smtp-Source: APXvYqxXWCMf0qfHtlGiudt1JYa6r7D+N922dA+0+0dKf1jFQZK7jRte9mwpIS0pz5gCnIJ+l4oHAQ==
X-Received: by 2002:a37:8e81:: with SMTP id q123mr3890465qkd.15.1571501579932;
        Sat, 19 Oct 2019 09:12:59 -0700 (PDT)
Received: from ?IPv6:2001:1970:535e:cd00:e378:c9fb:7183:d83d? ([2001:1970:535e:cd00:e378:c9fb:7183:d83d])
        by smtp.gmail.com with ESMTPSA id 60sm4637878qta.77.2019.10.19.09.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2019 09:12:59 -0700 (PDT)
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
 <20191010095650.GC7658@zn.tnic>
 <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
 <20191010134128.GF7658@zn.tnic>
 <60b68d6c-5aff-3e7c-9461-c26a5f28cd87@amd.com>
 <79bca0d0-42eb-c232-6bbe-a958734e096d@gmail.com>
 <f5820b41-c97a-b6be-df97-bbff85a7e5ee@gmail.com>
 <20191019082554.GB5571@zn.tnic>
From:   Jean-Frederic <jfgaudreault@gmail.com>
Message-ID: <fddfb084-69a0-a913-f750-ef0a7830dd1e@gmail.com>
Date:   Sat, 19 Oct 2019 12:12:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191019082554.GB5571@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2019-10-19 4:25 a.m., Borislav Petkov wrote:
> Look here on page 6:
> https://www.amd.com/system/files/2017-06/AMD-EPYC-Brings-New-RAS-Capability.pdf
>
> It hints at what PFEH does. 
>  [ I believe if the error cannot be handled by the firmware, it gets
>    reported to the OS but I'll let Yazen comment on that. ]

Yes, I found that document too after I sent my email yesterday, and I kind of
had a similar understanding...

> I know, I know, we don't trust the firmware to do it right and so on,
> but it is what it is. Like other stuff we have to rely on the firmware
> to do right.

I think we would all like to trust the firmware if it was clear what it is doing
to be honest.
However the way these consumer products are sold and documented (the motherboard I mean),
especially for AMD RYZEN and ECC support, is just that there is almost no information
(a vague statement aboutit "supports ecc"...)

The concept of the PFEH and RAS I think is good the more I read about it, but mostly for
enterprise solutions, and it would be good too I guess for a consumer product if we knew
we could rely on it.

As it stands right now, I don't really know if I can trust it. When I did my own tests
of generating real errors it was either the system is totally stable, or would not boot,
or would crash suddenly. I could see that ecc really corrects things, because otherwise
I would get software self check errors in mprime under those conditions fairly quickly
(after 1-2 minutes), but with ecc enabled I can run for hours without any sign of issue
under the same conditions.

So can I rely on this to know one day that I am starting to have hardware issues and I
should replace my memory (or system)? I don't even know how the firmware will report
anything to me. There is nothing in the bios that seems to give any report about ecc,

> Makes more sense now?
>

Yes, it does makes more sense now, thanks Borislav for all the information.

On my side maybe I'll start looking at other motherboards that potentially do this
differently.I'll continue to look in other forums to see what others have found for
other motherboards.


Thanks,

-- 
Jean-Frédéric

