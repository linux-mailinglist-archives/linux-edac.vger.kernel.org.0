Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF227B7DA
	for <lists+linux-edac@lfdr.de>; Tue, 29 Sep 2020 01:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgI1XTA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Sep 2020 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI1XSn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Sep 2020 19:18:43 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F25BC0613AC
        for <linux-edac@vger.kernel.org>; Mon, 28 Sep 2020 15:41:50 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o9so2933141ils.9
        for <linux-edac@vger.kernel.org>; Mon, 28 Sep 2020 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gaA/nbho2rHBM2XGAt+fqZDqrrCyGQoKDIGncDoowiY=;
        b=WpOlbRfAI9e8II+dnFUMmLCr028LWtZq3VDo3e7fgu588x0zs7KTTS1rPIT60wbAGy
         cFwY0h5dO4zkUJdnxSGUKs+097/h1H6C3mMVF+vw66IPMyv0pyTPefuI3b/L1Te3OJTD
         5HSxT4otUXABTWMa/ya8prB3WhIkjEBLxYMM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gaA/nbho2rHBM2XGAt+fqZDqrrCyGQoKDIGncDoowiY=;
        b=iQwKsSenb0xfLtnBqM4X4oXkPMkL9It95bsFljAATzdhjVEp+taSXWrm2bMnQUlSUX
         z7EbRmQHxpLPjiGyZhoKnMQLdOSsYXBMdJ6MMnk0cH5FH1iRsKDhEjg5EB2lfiMzZyjw
         j6ayeHnF8AZMmhimNTKSyHZZ8j6G8kaoMwqEU5ir1Qy16mq66UD8fprUb4x5Yk6357vo
         soBMKHet+aENObDSunjXXJr/Akd51M8pDZMCICOfjxgV4J+Kzxzij46UjnvvEbymc7XE
         jzMmmNMuANPBvXl62JAP3ugZ+k6OhPQsnH9rxlmR5FwM+yLp/MltHFgmXCJCbNPQG2r0
         MnUQ==
X-Gm-Message-State: AOAM533yM00ugtCxksegyI1ExrWeXc+QzwcsUySX/KGP9I52Il6m2khG
        2YGsdLcBdGTjAAIitTUa047gbg==
X-Google-Smtp-Source: ABdhPJy542a1CRGETx+C2//Kh61RETA39sKIv4QHpJwtOuYxcYdasZxM/JVddvpjSYaGDww7kJ0Sww==
X-Received: by 2002:a92:8452:: with SMTP id l79mr459458ild.222.1601332909461;
        Mon, 28 Sep 2020 15:41:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j1sm1334685ilq.74.2020.09.28.15.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 15:41:48 -0700 (PDT)
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
 <202009260923.9A2606CFF6@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3929a023-eb7a-509c-50e1-ee72dca05191@linuxfoundation.org>
Date:   Mon, 28 Sep 2020 16:41:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009260923.9A2606CFF6@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 9/26/20 10:29 AM, Kees Cook wrote:
> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>>     7. Verified that the test module compiles in kunit env. and test
>>        module can be loaded to run the test.
> 
> I meant write it using KUnit interfaces (e.g. KUNIT_EXPECT*(),
> kunit_test_suite(), etc):
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/
> 
> Though I see the docs are still not updated[1] to reflect the Kconfig
> (CONFIG_foo_KUNIT_TEST) and file naming conventions (foo_kunit.c).
> 

I would like to be able to run this test outside Kunit env., hence the
choice to go with a module and kselftest script. It makes it easier to
test as part of my workflow as opposed to doing a kunit and build and
running it that way.

I don't mind adding TEST_COUNTERS to kunit default configs though.

thanks,
-- Shuah

