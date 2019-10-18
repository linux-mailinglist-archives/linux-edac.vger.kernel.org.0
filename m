Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7A62DD52F
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2019 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJRXIg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 19:08:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45115 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfJRXIg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Oct 2019 19:08:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so11416006qtj.12
        for <linux-edac@vger.kernel.org>; Fri, 18 Oct 2019 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pCUmIwaumo4m1qSneO/ayd0Kxkg6qqbU0zqjttUgm9k=;
        b=KBO2aWx7SjGN3w1Km/rmt3dzKsLkC0RfxEEedhPx8iwWowjlf+pgiCC74KF88XAGAs
         pAbwOMxvjT9ddRHXv/u2CX6msLsexqXfelu7qkUncMmo+VxOkqzINYXBJm8RaFIF3ouL
         4EBRRQH3/P9Gufc7gNAbW1WtA/+6tu/fdEIflnTNBZZmRb5UWw0sX1XNeBK/944WGWO3
         ldBWrYyqvNSQ00WT29CTFBnf34LB4bLpleBYsV2qYdo+h/7AFJUShfObOyTAGFk/E8lY
         OYl9ZD70BIVBDAHBqrLKFFIF3htNzulzyW3u2XNUutx2+pP2YAx18s2BpIwZ1KubnTYh
         jG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pCUmIwaumo4m1qSneO/ayd0Kxkg6qqbU0zqjttUgm9k=;
        b=a/lsbIQFzlU8nzKFyWkf1spz29RdimfCuGuUaTUj7cmhZUyWmKHKpE68xIVDrwR7yE
         dygU0Z6zIsJYRZxbGyDueQGM+vsSyH9DMuu29M26PGJ5zTOkoYGc8PsKBCreYBCnuMK5
         kYcqTMxBfOw0wgW5xkgGHAESFuLbivZIAcZash5WlwvFldRwvTiKSK4UMmHItnzOFLWg
         HihLoxr3QZeIUON5PmWuaW4cwXaqruPyOAAok1jmqLPARBXzA/0OrNsyXfpx9H4gpTcp
         8qSPoqqvFdSvJzgHnpJ3FUmBCrtTs16giLy5HyMbYCJvrZBAOG6KmCu0d3+Ptqpqpk8G
         ncpA==
X-Gm-Message-State: APjAAAVFcWuEvh87e6HqrHEUdhzpcB1yyQftEKqaLBW87sj5EzTJUfRT
        YutSShnfk/MVTHT8tvP5til8MQgv
X-Google-Smtp-Source: APXvYqzS5+8rH+qyFDfbPRBQTyWD+DAaDaWJua6BsihmJav8HzBHcE9W/2O9E9SCFMY2ulJE+g61Kg==
X-Received: by 2002:a0c:ef11:: with SMTP id t17mr4983904qvr.3.1571440114628;
        Fri, 18 Oct 2019 16:08:34 -0700 (PDT)
Received: from ?IPv6:2001:1970:535e:cd00:e378:c9fb:7183:d83d? ([2001:1970:535e:cd00:e378:c9fb:7183:d83d])
        by smtp.gmail.com with ESMTPSA id w131sm3729254qka.85.2019.10.18.16.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 16:08:34 -0700 (PDT)
From:   Jean-Frederic <jfgaudreault@gmail.com>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
 <20191010095650.GC7658@zn.tnic>
 <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
 <20191010134128.GF7658@zn.tnic>
 <60b68d6c-5aff-3e7c-9461-c26a5f28cd87@amd.com>
 <79bca0d0-42eb-c232-6bbe-a958734e096d@gmail.com>
Message-ID: <f5820b41-c97a-b6be-df97-bbff85a7e5ee@gmail.com>
Date:   Fri, 18 Oct 2019 19:08:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <79bca0d0-42eb-c232-6bbe-a958734e096d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2019-10-10 9:04 p.m., Jean-Frederic wrote:
> On 2019-10-10 3:00 p.m., Ghannam, Yazen wrote:
>> 1) rdmsr 0xC0002003
> This returns 0 for me, so I guess PFEH is enabled.
> As long as this is only for the error injection, and is not preventing
> the actual capability for the OS to report the memory errors.
> I'm still not clear on that part.

On 2019-10-10 5:56 a.m., Borislav Petkov wrote:
> On 2019-10-09 7:54 p.m., Jeff God wrote:
>> Would this setting also prevent error reporting at the OS level or is
>> it just related to the injection?
> Platform first error handling meands, the BIOS gets to see the error
> first. So it depends. Yazen, do you have the whole PFEH functionality
> documented somewhere?
>

I don't know if there has been any new information related to these last
points, I am really looking to understand if ECC error reporting will be
working in this new Kernel 5.4 for AMD Ryzen 3900x (or are we saying maybe
this issue could be related to the motherboard?)
   
In any case, I think EDAC needs to be able to tell us (like at boot time)
if the ECC error reporting is working on the system or not, because right
now (in 5.4) everything appear to load successfully (according to dmesg)
with all the memory information identified, and edac-util tool appear
to be working (and returning zeros).
I don't mind if the error injection part is not working, I think it is
more an enterprise or debugging feature.


Also, since this was working on the previous generation as mentioned before
(i.e. AMD RYZEN 2700X and ASUS PRIME 470 to be more specific), I thought
it would be natural that it works on the newer gen, given the
information/hype provided around launch time.Asus also confirmed to me
through their support that this new motherboard supports ecc. It also has
an ECC option in the bios, as I've mentioned, to enable or disable ecc.


If nobody know the answer to my question, then that is fine, I just
wasn't sure if it was forgotten.


Thanks,

-- 
Jean-Frédéric

