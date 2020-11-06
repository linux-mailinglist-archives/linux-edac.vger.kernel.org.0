Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD44F2A9E1C
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 20:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgKFTel (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 14:34:41 -0500
Received: from foss.arm.com ([217.140.110.172]:44060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFTek (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Nov 2020 14:34:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 696AF1474;
        Fri,  6 Nov 2020 11:34:40 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31CBA3F718;
        Fri,  6 Nov 2020 11:34:38 -0800 (PST)
Subject: Re: [PATCH] Fix randconfig build error and code bug
To:     yaoaili126@163.com, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de
Cc:     linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        yangfeng1@kingsoft.com, CHENGUOMIN@kingsoft.com,
        yaoaili@kingsoft.com
References: <202011041829.KUaqiCq1-lkp () intel ! com>
 <20201105114326.353021-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e35267a2-89f3-c5c1-119c-ce4eace8623e@arm.com>
Date:   Fri, 6 Nov 2020 19:34:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105114326.353021-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

On 05/11/2020 11:43, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> CONFIG_ACPI_APEI is not sufficient for ghes module global function
> replace it with CONFIG_ACPI_APEI_GHES.
> 
> When gen_pool_alloc fails in ghes_in_mce_cper_entry_check, we still need
> to try other cper table to get it cleaned even we are likely to get another
> allocation fail.

This applies on top of your previous patches. It doesn't make sense in isolation.

When this happens its normal to post a 'v2' of your patch with the issue fixed.
If you only just posted the first version, then it is best to wait a little to give
reviewers a chance (multiple versions posted on the same day is too much). In this case
its good to reply to the build-robots' message saying how you've fixed it locally...


I think we need to find out whether your firmware supports GHES_ASSIST before we make
changes here...


Thanks,

James
