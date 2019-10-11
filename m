Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9273D36AC
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 03:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfJKBEp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 21:04:45 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:39185 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJKBEo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 21:04:44 -0400
Received: by mail-io1-f49.google.com with SMTP id a1so17973660ioc.6
        for <linux-edac@vger.kernel.org>; Thu, 10 Oct 2019 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QBiiW8Wzt/6oy/sRunGU14hbYMniWxRKb+1fPodITQ4=;
        b=cpQhwbd8njULq69c5FEYKYXCfdkLodvkXI+sFtKj8Y2ENUriHECG3WgcAsJ0PxOjv7
         H8m9DwvxVgpDKlN1V6qEau1t5Sdvh1q58T6VNjd/+hR1QokUCTg5HM7Wm7ucOWwkDd7A
         ArwYnEdYZSCjw1qxSMarZ5kX1gjkS23JdbC/KgfUlrPj5gqfzaMKe5K3OBphJKlo3Ckc
         oZujZqeA5gpgRpfcC94drhxj03AdYgEtDqpRJFyNVEURS0h26Yc4vfr4ZAY99NTkfQE5
         LWj4UGPxZQS7oMnlbEcr3vJte69u/ysWeVCPMjUjqnOMHqCGS6CqLlM3/avUWw87QGq4
         01ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QBiiW8Wzt/6oy/sRunGU14hbYMniWxRKb+1fPodITQ4=;
        b=HhGGEweh/toin2QmVkFBOrHzNs/C74HhVNgh3CXGwjXGHTP+DAanHGGVZZECTv1PYN
         +gObfjG6Vig0O1RFFobeBOO0VSeQc68SeCNqizqvbqpXLSAiD5XnlAgsGQf/FLlLgxrZ
         ZNiA0eWMlYP3gP9bEHVk/hiRY8V/dj6aj/w2LgM5yAahR7UAUP73GTGUqQrHL24NN7CT
         EhTaQa4DmDxr8CyydhAfdQmntuElwS9z7nu4TzLRZedsidkdYEBq4hdBhZvaniNfSQda
         /FGs/rknWQXfxREsaErZlaXVG2Lk+So6Xr3lcQic6xOM1DROhkDD1eflL5rjeJgC/dWz
         QEtQ==
X-Gm-Message-State: APjAAAXXP3IFWTov9B+K9nW2HPRRRvivLoH07TYn8Ji+Nu/Uc8yAJoRc
        /i3wBW0ziMSTDRLYxmkO+bVdS7nP
X-Google-Smtp-Source: APXvYqySA9ikj0pu0Y816vuViZLZz+G4GwrGIbjSz1Bf2XZwbuxkMPY0qo1yLfZyaIe93OoVJ9YIIQ==
X-Received: by 2002:a02:3081:: with SMTP id q123mr14315177jaq.24.1570755883434;
        Thu, 10 Oct 2019 18:04:43 -0700 (PDT)
Received: from ?IPv6:2001:1970:535e:cd00:e378:c9fb:7183:d83d? ([2001:1970:535e:cd00:e378:c9fb:7183:d83d])
        by smtp.gmail.com with ESMTPSA id k7sm5609537iob.80.2019.10.10.18.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 18:04:42 -0700 (PDT)
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
From:   Jean-Frederic <jfgaudreault@gmail.com>
Message-ID: <79bca0d0-42eb-c232-6bbe-a958734e096d@gmail.com>
Date:   Thu, 10 Oct 2019 21:04:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <60b68d6c-5aff-3e7c-9461-c26a5f28cd87@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2019-10-10 3:00 p.m., Ghannam, Yazen wrote:
> Jean-Frederic,
> Please do the following if you'd like to try this check:
> 1) rdmsr 0xC0002003
This returns 0 for me, so I guess PFEH is enabled.
As long as this is only for the error injection, and is not preventing
the actual capability for the OS to report the memory errors.
I'm still not clear on that part.
> This command will read the MCA_MISC0 register from MCA bank 0. If it is
> non-zero, then we'll know that PFEH is not enabled.
>

-- 
Jean-Frédéric

