Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3264527B7D9
	for <lists+linux-edac@lfdr.de>; Tue, 29 Sep 2020 01:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgI1XS7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Sep 2020 19:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgI1XSn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Sep 2020 19:18:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D02C0613B1
        for <linux-edac@vger.kernel.org>; Mon, 28 Sep 2020 15:42:49 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z5so2962451ilq.5
        for <linux-edac@vger.kernel.org>; Mon, 28 Sep 2020 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lfWeOnITWCeijLSuxzxiSIPC5xTsdC1wKnU7B3ZC5Lk=;
        b=beQywzattpQ6h9VxrWUUjSXbW2NzdQ7tN01P6Fxu3w0DElSH99yNXq/oeDtcSOP/9X
         EENXteBPokqZCQ4iUMEdnei6q+cCq5jNGrbY/ShMUDDnZsK5zrAkesLqvzbzRHGHUd2D
         ZDoxf29bX/+HC/gfcdQn6A5JV5Bg+hGw1IFG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfWeOnITWCeijLSuxzxiSIPC5xTsdC1wKnU7B3ZC5Lk=;
        b=l1kZvcQp/uoXjZbApXPsEtEoOtRgFt8fDhW8G7T2YVTjY/+GPOCg9SqA4P9Ssxuuyr
         cbE6IKXOzHgYx11i0Bfiu9wiKJftx9z+Fxngtm9gsWHHN/VHN/f2ZBSlAttqlUA8rjbf
         SOKf8EV+gC5B3RfWbioINPklslwrHzi9HGWnBTjvp6cxgVzlSBsdW/XiFXmPU95nkIN5
         LVLNj+yAT9eIT8mJtiOYkwznwk149mpQXh4/v4JliHBPm6yzUcH4Pma5Fb/A/FX3zoyG
         nVHLgXO08ur7LDFbteG5b+l44n1ZfZziQu03RanZRAvxu6u5fwEO9dC6iTnR7xBxmKXb
         9PJg==
X-Gm-Message-State: AOAM530oy6H02kDkNMY4GPBgLB0CE3hNzDzxOomcx+Kz6fuaYmxZWti3
        ZGiuOdKvnXhmq6wwhh8gKOa/Eg==
X-Google-Smtp-Source: ABdhPJwo+pvtsIEQwf41bcDHTqwQ2dD5eUFFFgp4elRZ673xZA4id8e/WXiXlaCwN8OjTLklnmPUJQ==
X-Received: by 2002:a92:8591:: with SMTP id f139mr533509ilh.164.1601332969021;
        Mon, 28 Sep 2020 15:42:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l9sm1317402ilf.65.2020.09.28.15.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 15:42:48 -0700 (PDT)
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <202009260920.DC9C2743@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1aeccb4f-df7e-60bf-1d70-dfcff5bb6f87@linuxfoundation.org>
Date:   Mon, 28 Sep 2020 16:42:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009260920.DC9C2743@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 9/26/20 10:22 AM, Kees Cook wrote:
> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>> This patch series is a result of discussion at the refcount_t BOF
>> the Linux Plumbers Conference. In this discussion, we identified
>> a need for looking closely and investigating atomic_t usages in
>> the kernel when it is used strictly as a counter without it
>> controlling object lifetimes and state changes.
> 
> BTW, I realized the KSPP issue tracker hadn't broken this task out of
> the refcount_t conversion issue[1] into a separate issue, so I've created
> it now: https://github.com/KSPP/linux/issues/106
> 

Cool. Thanks.

-- Shuah
