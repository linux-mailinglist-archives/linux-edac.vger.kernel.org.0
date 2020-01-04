Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9701304BC
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2020 22:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgADVrm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 4 Jan 2020 16:47:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34255 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADVrm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 4 Jan 2020 16:47:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so37038039qkk.1
        for <linux-edac@vger.kernel.org>; Sat, 04 Jan 2020 13:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SnFTnKx2lZ4rjjQb3CYdShbRp/3ADmmfD/jJ450P1Q0=;
        b=oCafgkIsTaVSomynfZi2HuvkMA5hNNSsqtnZCcQcIxEzNImhqo3KJKYJGDhA14SEk4
         wBJE2B4Axlz1M0DQi7w9nfaqjczDRWbueJB2eTRYf2XIeIkc6v8MeMY1U5tw9nRFtrs6
         ADyQio1kdKhdDeLtCr1eq11CltpcRiy0nBpysZD1Vx9zX2cx/bpylI4TXK43Ab70E8Qr
         dM5e+s1A/xhoRFiECaBkTddRkYYoRae52WxPyMpAwNn2qDZuz/8vR14u4AVx3JGpWJ6s
         pJIDNWpYwTh55/mO9/U0QDJ7GJaQpbcJG7kBgORktKD1tpWfVh8a0Xzy74ZdhpCmODtf
         91zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SnFTnKx2lZ4rjjQb3CYdShbRp/3ADmmfD/jJ450P1Q0=;
        b=oJ/oFed9lW2PQ9OPZGOu91N/UWGDvxhOrcsmjCec3VSO53fJ4x1VUKjtD5id6HUKmV
         k18ifT86TVXnL54qhq9sUMfjmfOePIhPs8MPoAOSMgmcq5DjAE88EAou3dFnFCiAs8wx
         yD5kUlVhEhEO8vfe24Mb/p2F4ES3M80ouI+JgdHsReyeSyw8TmT3lVm8XOv09Iu6YVHi
         7zqkdM29o7oS1VIZhQ5XoLRfOmfZcbkdZLoS7poVjVFlWsYPqdqSphhXvi9s4H5Bk2aF
         jJk4P5flViDTvPuInhhwUHr72am3SlN8PlFRuTGLnC0J8yqBCOq9BfRihe3lhZxrOY8C
         /Aog==
X-Gm-Message-State: APjAAAXWeYemTz8BPBqYVjqIXguq2efzAUWQ5U9Q+gzzsLTyR6npTawP
        yrh1d+0ANtr9SfnoAG6H39skqFsr
X-Google-Smtp-Source: APXvYqw2XVKQ7a0SoK+NXARqQuvu6oxVmmq6tbwWCw98Kt33Zp/SGj9C1SYqFqzgDm/vhXg4nFA9Nw==
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr71660846qkg.489.1578174461086;
        Sat, 04 Jan 2020 13:47:41 -0800 (PST)
Received: from ?IPv6:2001:1970:535e:cd00:e378:c9fb:7183:d83d? ([2001:1970:535e:cd00:e378:c9fb:7183:d83d])
        by smtp.gmail.com with ESMTPSA id t73sm18579265qke.71.2020.01.04.13.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 13:47:40 -0800 (PST)
From:   Jean-Frederic <jfgaudreault@gmail.com>
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
 <fddfb084-69a0-a913-f750-ef0a7830dd1e@gmail.com>
 <7acbeaaf-27cf-0c04-5979-b362f770bc00@gmail.com>
Message-ID: <6d9b37f8-e753-8c9e-55b9-547c19b02df2@gmail.com>
Date:   Sat, 4 Jan 2020 16:47:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7acbeaaf-27cf-0c04-5979-b362f770bc00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2020-01-04 15:03, Jean-Frederic wrote:
> I'm not too sure I understand what was the exact problem but it really seems
> fine now. I also updated my bios meanwhile but it did not mention there was
> anything related to memory or ECC fix. It just said Improve system
> performance.
> (bios version 1405 for Asus PRIME X570-PRO with Ryzen 3900x)
It seems after all that the real fix may be in on of the last bios update I've
applied, because I retested with kernel 5.4.2 and even 5.4.0 and I now
get also error reporting there, although there is some call stack trace
logged in dmesg, so the newer kernel > 5.4.2 appear much cleaner in
logging at least.

Also now when I do rdmsr 0xC0002003 it returns non-zero, which
wasn't the case before.

-- 
Jean-Frédéric

