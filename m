Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6E1443B9
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2020 18:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAUR4T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Jan 2020 12:56:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42312 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUR4T (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Jan 2020 12:56:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so1645179plk.9;
        Tue, 21 Jan 2020 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+7UcIYyupUrT8UqdxAteZ1t6SxPyW7FNiWE6g1e+Uv0=;
        b=AFneFU8tAym4plBbE3InWVUlktNscK05ah9eYmr0DAdE4uVt0eTf6ci/Lze8YwFscS
         Yo+xartsefE6e+d2YjyWuvh5AiWVNh+1XiKKLeyIV75G/vYO7grsQ2S7fHMY9VDmrwLq
         ZbqP+b/hf4LnBvYkHk6Muv1atfQc+csSQ7Z/Jp1xcnbTxSOWGaKkyviEwq7nOnVne+UP
         IdguyqsifpLz1gkpSE2NyCWWrzRMVqPwE9XT7u0EHUoqd0c5RLt2ZpT7s2nPqfsMxHFJ
         GTEoc9sNOr+ITUAWqrpAHkRRoA4+g3bPmC2B3VUyzyzVQPyGMDeeQs4lO0OUMpzNCaE4
         NFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+7UcIYyupUrT8UqdxAteZ1t6SxPyW7FNiWE6g1e+Uv0=;
        b=Y1BvCaW/sxBRQ0n/IW8faZkBpxASaDD4mOYowH9c/95cfOI8peOSIEW0Z6R/d+/gcz
         MGvG+PD5ZLl9ymt/gxApN+WCtRyau1auyJyJX9TXYE5eoM1gJXplcZylAAM9bxyA/eei
         NREzd1zr3vibNB/sHaApSGFqixYFLKO8/L3VASQwZoti6wNTxIua5QIwxj7KCeCMj0wd
         0GEWqA8Ih//YEDx9c0DICesUyeH03jFVRBUEjnjWoJCEgGaJ/sohwcMEiMts4colOzB7
         jb+3lMWLSHpBuCIVU2Lgf6YGu/n3vVdwnpgTDqYjuzgTH30ZYq6wXWLNGgmalnBZywO5
         ehlw==
X-Gm-Message-State: APjAAAVCr2sWTgfpLygif8CFWHbBgduWNsKcsg4azoKjpmjlntg5Ant/
        sL+AHl7quBjm+I+JYhUsFDQ=
X-Google-Smtp-Source: APXvYqzF3Luq7je6jNzK1lpqgZmnNfY1NSaU0MalFpmd0APMREaWtHVxWlb7Ns7PUC8OMAHl2iwR2A==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr6430870plr.336.1579629378476;
        Tue, 21 Jan 2020 09:56:18 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:140e:bf9b:65a6:dd72? ([2001:4898:80e8:8:941d:bf9b:65a6:dd72])
        by smtp.gmail.com with ESMTPSA id fa21sm76780pjb.17.2020.01.21.09.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 09:56:17 -0800 (PST)
Subject: Re: [PATCH v9 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>, wangglei@gmail.com
References: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
 <20200116233939.GI27148@zn.tnic>
 <CAL_JsqKqC_xm9rrHYaO87BtEv=-ji080p_G8axFduqu1mcqHCA@mail.gmail.com>
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <0723718a-f359-77b2-f66c-dd531cb19952@gmail.com>
Date:   Tue, 21 Jan 2020 09:56:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKqC_xm9rrHYaO87BtEv=-ji080p_G8axFduqu1mcqHCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/21/2020 9:53 AM, Rob Herring wrote:

> Would be happy for a schema, but not going to ask for that on a v9.

I drafted the schema, do you have some tools/instrutions to validate against the DTS? I want to make sure the schema is indeed correct.

Thanks!

-- 
Best regards,
Shiping Ji
