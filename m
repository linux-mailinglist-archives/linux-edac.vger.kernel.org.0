Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA21F9B43
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jun 2020 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgFOPB0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Jun 2020 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbgFOPBY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 Jun 2020 11:01:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB153C061A0E;
        Mon, 15 Jun 2020 08:01:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so6958836pjb.0;
        Mon, 15 Jun 2020 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PIF5e8K3q0e7NGWwSzCLOMuB5EYjzZTGf/QhEJ+wTt0=;
        b=OKZC52Ui/7+4r4w4WhEFNgl/jQeuvFXAADk0vtf9J7DJIKVztfzZGbG0wALTt4RQhA
         gK44MhcxZqZb0/R0Syeq0y5EZQVfGzJ0dR6/VMo5pqY7wEPe+SDP+Uk4IKhAmEjgMs6F
         K6eCTGvbM3YJYU314mCmC/Q/8CfSqbqmUaGBSQSN2WPSRSoOsZoi5gMYRp3mJXFXFVB1
         H6KCRE/2kPUVdGOHjzjivDBVnN1IuWO/53v41IVkyQS6v899JV4sSK/02iwqF6XwTzmP
         jeJS/bNlWyLIoEtFaYLgOwbundxZpGjefaKtoMmzKHwtglzYbpres+i9NLV9+dQrMaPU
         324w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PIF5e8K3q0e7NGWwSzCLOMuB5EYjzZTGf/QhEJ+wTt0=;
        b=l1HgJ3ENNksh3nxXTw0WxHC43Ys3a85FUk+w2Hxx0/ezU2M9YwtNnsTEVtnxwfAXtF
         V4sqpt0q60dUYENgkDZ0U7V1y1iKtWuts9t4zdbIINAGrnt9LahyaSb2NyNt1ol4YHYV
         fI02myAn83fRDzP3RVw7CnT4GUmzFFKSiJ601Nfq08UxwcypT+oGSSHAMO7vRojCcNDR
         XQaXzODhBSvGHj6Fbl/+FAIYbLUyDrx/ti8Psfhovd38Y5fanrpMdDAOG9FCoL7UkKKT
         d+vTO2NO3ooeinWlJBrncNOwLyxHk2wMvo7zPfevTOQPMoxzaWKXVKWptKfCiVVySAAc
         ydow==
X-Gm-Message-State: AOAM533be/BmbjPEnfOb2mceEncT1qBMkEbGecn3xuwNqsYC17gRV6go
        O/HJLRrXrQJ2OtFQ0FKS3ZniQnaA
X-Google-Smtp-Source: ABdhPJwuAoJMmw1d1eAx382Qgrf0SyTxlzhfUhGXYj6pc4gbpdsUacnnSgQowdOaG1diyOGfe7UUhg==
X-Received: by 2002:a17:90b:190e:: with SMTP id mp14mr12363004pjb.198.1592233283856;
        Mon, 15 Jun 2020 08:01:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b5sm14346660pfg.191.2020.06.15.08.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:01:23 -0700 (PDT)
Subject: Re: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
To:     Borislav Petkov <bp@alien8.de>, Jacky Hu <hengqing.hu@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-hwmon@vger.kernel.org
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
 <20200615115950.GG14668@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a9d0cfc4-1aed-d6ed-c6f2-336b56d91f20@roeck-us.net>
Date:   Mon, 15 Jun 2020 08:01:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200615115950.GG14668@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/15/20 4:59 AM, Borislav Petkov wrote:
> + Yazen and linux-hwmon.
> 
> On Sun, Jun 07, 2020 at 12:37:07PM +0800, Jacky Hu wrote:
>> This patchset adds MCA and EDAC support for AMD Family 17h, Model 60h.
>>
>> Also k10temp works with 4800h
>>
>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> Vcore:         1.55 V
>> Vsoc:          1.55 V
>> Tctl:         +49.6°C
>> Tdie:         +49.6°C
>> Icore:         0.00 A
>> Isoc:          0.00 A
>>

Looks like we may have to black-list current measurements
for that chip, though.

Guenter

>> Jacky Hu (2):
>>   x86/amd_nb: Add Family 17h, Model 60h PCI IDs
>>   EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh
>>
>>  arch/x86/kernel/amd_nb.c  |  5 +++++
>>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
>>  drivers/edac/amd64_edac.h |  3 +++
>>  drivers/hwmon/k10temp.c   |  2 ++
>>  include/linux/pci_ids.h   |  1 +
>>  5 files changed, 25 insertions(+)
>>
>> -- 
>> 2.27.0
>>
> 

