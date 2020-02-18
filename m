Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7AF162BCC
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2020 18:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRRMR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Feb 2020 12:12:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34434 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgBRRMR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Feb 2020 12:12:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so10986425pfc.1;
        Tue, 18 Feb 2020 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BnPFaeZ3s43WUYcze9Kwo0dphRPPj2p/nuAOY7Iiq+8=;
        b=Tvwpfn+F2RvTr98QbZKPePm7QRSSanWAsEG7c+BMFMe4LjUC0xiReKD6HTVbuLqwCC
         KxeMbvctk6orp0LF6ZmK4Raz9N5eMNa+3u057kXwzlSxKNNFL2rgKqc1Z/v7LqXWhNdM
         EMJpMOrJx1o601n7D1CXRLhaB0NCZhCAhcBPftpV2YBuwXsnVKRqiZ+xafIif7WvE6Ba
         FMYCHafYDNB6P0q8YKY58lDMT7zKDC0F/HhYjtoSXkTqfvSqFOosITPrtyry7FUfv0uB
         AMUYUp/P06ZSbJ7xx2KbYIzOiYmkX0/H2Q67DEnn5c6MfcIT9bvD4t+utKDRq3UaNVaR
         3Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnPFaeZ3s43WUYcze9Kwo0dphRPPj2p/nuAOY7Iiq+8=;
        b=GHZs6MFwWPfAGavj+ZmIZKLgFPXQIcjb56XCXRN+avwbB+4YwbUwyjXhmP7nbv/Z7o
         uW9tKedIXALWALYMLuJ8bt+YoX39QG/WMyrV2j73A8rEo1KAzFo9AlrM+ZZoJJtN3LLT
         q6wEY6qNgXN0+RAhr01PMoRjpt/NHG+rx9L+kivXYN7C25b/ratGgLBwMecZv8lq0Vbv
         NlfoV1ydlCtSiUKtbN++FRyO1I56DwHvzQrn616FPxf23zsPdZKCIqKTvGPRCA8DE3mX
         1W10GOgnMh4mO/zQ16K27kT41QAB33jqy7gO/WeXlczbzDQ1zOnOshus1XO0OTgOuqWF
         anng==
X-Gm-Message-State: APjAAAW06LP3+CBmxb/UtC2sla7TdWd9fHBULO6tekahtYr5fOVDW3FB
        UuvdIxgi8Dxzc7ujvY+TKtU=
X-Google-Smtp-Source: APXvYqzISR3SCcV6wjCMjx4AhKC6RIu/lfMH3tpyp9bPHw1FkmDVC8A6IfL0knG5wA4RMVhycn84hg==
X-Received: by 2002:aa7:9546:: with SMTP id w6mr22056881pfq.66.1582045936454;
        Tue, 18 Feb 2020 09:12:16 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:a99d:cf29:8886:cbc? ([2001:4898:80e8:2:29b3:cf29:8886:cbc])
        by smtp.gmail.com with ESMTPSA id z10sm5534950pgf.35.2020.02.18.09.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 09:12:15 -0800 (PST)
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
From:   Shiping Ji <shiping.linux@gmail.com>
Message-ID: <4c02326d-cf38-e1e1-1822-d24de22fa2cc@gmail.com>
Date:   Tue, 18 Feb 2020 09:12:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217181055.GC14426@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2/17/2020 10:10 AM, Borislav Petkov wrote:
> I have only this v11 patch 1/2 in my inbox and not the actual driver,
> i.e., patch 2/2.
> 
> For the driver, I have v10 here:
> 
> https://lkml.kernel.org/r/83b48c70-dc06-d0d4-cae9-a2187fca628b@gmail.com
> 
> Did you send a v11 of the driver itself or should I have a look at v10?

Actually I didn't send v11 of the driver since it will be identical to 
v10, sorry for keeping you waiting on this. Please review v10, thanks!

--
Best regards,
Shiping Ji


