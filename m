Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC4130449
	for <lists+linux-edac@lfdr.de>; Sat,  4 Jan 2020 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgADUEC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 4 Jan 2020 15:04:02 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:33209 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADUEC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 4 Jan 2020 15:04:02 -0500
Received: by mail-qk1-f181.google.com with SMTP id d71so28684482qkc.0
        for <linux-edac@vger.kernel.org>; Sat, 04 Jan 2020 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ManilaD8QzV+3THJ/Pmuq+fw9e2FCe9dDONWtwnKcBg=;
        b=YnCMlk6jH+S7rNkx8XdVfzdebjvYbWDrfgTIVxI1gjhTzRZPbAxFhvzk24r85u77ly
         dBW7EDlfyJupUzi2s1ALRkW1o4Sf/bJFnTeIS5FiQ3ChjrrpDha1kkORETgkbe4Nu6gL
         bQewtIm3DYajUr52v21i2OYHgtUR8AHhqHmB3PbiIrpqdgFB/Ff982rHmZoFqC8wrKvG
         lh3IJJ8kIhiqw6Ekbb3v9eLQWuQqaqX+Jj1b7+2KFgDZF4Sq6w2MJVOpoCDwMg0glbxe
         qthloMcZB76c1RHOyYrC9T1Tx8iMVUNCNHjldVgCIGAsl/vxqxiDtwBo7J6PQqwdX0pT
         RYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ManilaD8QzV+3THJ/Pmuq+fw9e2FCe9dDONWtwnKcBg=;
        b=a0PHhA2y8f4aK98GedrlVi3Pz6nhhcTNIRQTlzQP/KPFssfLXzFzq97ARRVI1bdU/f
         nM8xTf8z4bgyhGNAGxTNPGRymPftrZC+8h5WTAEzMRSvcEcneYsDTZwJshYCY4VL34/3
         MXqE1ElM9KMI/8E85YXt/gz+m6ruI+NvXIRTPtWr4jcec7BU3R6JIUMbHht0gsh2CG80
         TmU+TV/WTLb327v8E2KcEVionuahUX5G6waRyzU5tGGDDBgrbKpf3L6sm6jE7F6ilsJ3
         bZPfzWb3dDi/F5ww10uqv6cL9MIZTatiYL0OKbjLVaBd4wXtzXIbme9tRfqdO0MY9+xH
         utkg==
X-Gm-Message-State: APjAAAUoLlOW5AYsxldCwcnrL8l2+oD+SBBD9ozwuxmXUA+NkN9EXKpj
        mDs8+jFJMnpZyREDlVEGymdMzbEA
X-Google-Smtp-Source: APXvYqw6y85wVGyeWBC9N5D5nxqgzq1M6/GBZZmg8blSBrfQquRm9V5EYe6sRMBIlOyE2PCPf5i8Mg==
X-Received: by 2002:a37:de16:: with SMTP id h22mr76508186qkj.400.1578168240787;
        Sat, 04 Jan 2020 12:04:00 -0800 (PST)
Received: from ?IPv6:2001:1970:535e:cd00:e378:c9fb:7183:d83d? ([2001:1970:535e:cd00:e378:c9fb:7183:d83d])
        by smtp.gmail.com with ESMTPSA id 63sm18351383qki.57.2020.01.04.12.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 12:04:00 -0800 (PST)
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
From:   Jean-Frederic <jfgaudreault@gmail.com>
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
Message-ID: <7acbeaaf-27cf-0c04-5979-b362f770bc00@gmail.com>
Date:   Sat, 4 Jan 2020 15:03:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fddfb084-69a0-a913-f750-ef0a7830dd1e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Just to let you know, I have installed the kernel 5.4.7 (with RAS disabled as
usual) and now I can finally see errors reported for the first time very quickly
under serious memory overclocking conditions.

I've used the same test conditions I had before:
4 memory modules at 3600MHz 1.2V, 22,22,22,43 (Kingston KSM26ED8/16ME 16GB 2666MHz 1.2V)
However now it works fine and reports errors (all CE so far). I got 8 CE in less
than 30 minutes using mprime and my original method described before.
edac-util output:
mc0: csrow2: mc#0csrow#2channel#0: 3 Corrected Errors
mc0: csrow3: mc#0csrow#3channel#0: 1 Corrected Errors
mc0: csrow3: mc#0csrow#3channel#1: 4 Corrected Errors

dmesg example:
[ 1561.272106] mce: [Hardware Error]: Machine check events logged
[ 1561.272106] [Hardware Error]: Corrected error, no action required.
[ 1561.272108] [Hardware Error]: CPU:0 (17:71:0) MC18_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000000011b
[ 1561.272111] [Hardware Error]: Error Addr: 0x00000004e09173c0
[ 1561.272111] [Hardware Error]: IPID: 0x0000009600150f00, Syndrome: 0x000040000a801103
[ 1561.272113] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0, DRAM ECC error.
[ 1561.272119] EDAC MC0: 1 CE Cannot decode normalized address on mc#0csrow#3channel#1 (csrow:3 channel:1 page:0x0 offset:0x0 grain:64 syndrome:0x4000)
[ 1561.272119] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

Anyway, thanks again for all the previous information and work done,
I just wanted to confirm that it appears to be working fine on my side now.

I'm not too sure I understand what was the exact problem but it really seems
fine now. I also updated my bios meanwhile but it did not mention there was
anything related to memory or ECC fix. It just said Improve system
performance.
(bios version 1405 for Asus PRIME X570-PRO with Ryzen 3900x)


Best regards,

-- 
Jean-Frédéric

