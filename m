Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1CA1FB4D1
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 16:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFPOqk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPOqj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 10:46:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206DEC061573;
        Tue, 16 Jun 2020 07:46:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so5240544plk.3;
        Tue, 16 Jun 2020 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wp5M8tnQYT7iRVKebggcqWX6gRGut1Hkoi6yXdAIq0c=;
        b=m3FpMn0Hb64pQCP149bbxyapIdSQgqxjgxZBGjIZI21tRCZztfhMD6aamjeW8CmXPM
         U7nO4wiV/bV6y3Pt4nXyZLe/TUNy1rzlelPCtTIcWhdx61iyb7shjYcP678TXY6attG8
         XHjbngBn5N59Bds/xdZ23GUn2vEH9lxALTvDPNiukNl1PXh7LJrkfl9HqcQ+bF6CiO+U
         rZWHWEhUf6dcBwf/RobVhZ13mf/aHJhOf/fj1dF26SLV88EdYY8PdMIJjBoZjs3qZe7i
         vt/Yg4ea3f5tUk2r01mjY9mGN2njC+oXhh1OkunngcG60Iz/C5XHhtBFS4sZxThkjOPU
         qmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Wp5M8tnQYT7iRVKebggcqWX6gRGut1Hkoi6yXdAIq0c=;
        b=to/zHPqmZ7FngSGCX13QPvISR45yzRAzUr1e9J8fUm9J13XwCdUHyNFGbtZ0lOm4Ch
         bvGQt78dSHz7sXZJxeHJiGY7RLf+igOvcF/Je+D0vJ8Zk83oWrO+nYzEGKyiakeLC+I1
         RH5ENfau/hwLifo/JV+lwwUDvjPtgCdvCnk7KdopkbS2rYmhayR0CRIHOMeIfrWGLyv5
         ija43yKFxf3zV1qA28ALDFUPxYZDfzk+PD0taINkKu9RoQlve2YZN3EW+2caH5gzXM0H
         i48TlZx8IM7ELI4cSx+83wRJZkSjolvEi2hRBr+X8wr763eEP5qdwmvs4kPs9z6PrQ7D
         8Vhg==
X-Gm-Message-State: AOAM532TBBJzDbAVNV2urii2gA5QgGUJMXG8THRUN9Itn7yH4ruxGoOA
        F/Xdf4+A4ARn244cHmt4ofabTZGD
X-Google-Smtp-Source: ABdhPJxFjTLMU5EPu/DBjvRqE91x26mensCA5LghCmxC15P+zKUeH+HwWjuCA+92AdJF1oU8S7jKtA==
X-Received: by 2002:a17:90b:188d:: with SMTP id mn13mr3186865pjb.84.1592318798345;
        Tue, 16 Jun 2020 07:46:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k18sm17495730pfp.208.2020.06.16.07.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 07:46:37 -0700 (PDT)
Subject: Re: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jacky Hu <hengqing.hu@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-hwmon@vger.kernel.org
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
 <20200615115950.GG14668@zn.tnic>
 <a9d0cfc4-1aed-d6ed-c6f2-336b56d91f20@roeck-us.net>
 <20200616143517.GH13515@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a2f55a9c-25fd-d79d-5f20-8144694f394d@roeck-us.net>
Date:   Tue, 16 Jun 2020 07:46:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200616143517.GH13515@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/16/20 7:35 AM, Borislav Petkov wrote:
> On Mon, Jun 15, 2020 at 08:01:22AM -0700, Guenter Roeck wrote:
>> Looks like we may have to black-list current measurements
>> for that chip, though.
>>
>> Guenter
>>
>>>> Jacky Hu (2):
>>>>   x86/amd_nb: Add Family 17h, Model 60h PCI IDs
>>>>   EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh
>>>>
>>>>  arch/x86/kernel/amd_nb.c  |  5 +++++
>>>>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
>>>>  drivers/edac/amd64_edac.h |  3 +++
>>>>  drivers/hwmon/k10temp.c   |  2 ++
> 
> ... meaning I should not take the k10temp changes yet? I can drop them
> and take the rest...
> 

No, that is independent. It is more like a note to myself. I'll have to get
debug dumps from someone with affected chip(s), and for that to work
support for those chips has to be enabled in k10temp.

Thanks,
Guenter
