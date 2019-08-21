Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC10E98126
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2019 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfHURXD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 13:23:03 -0400
Received: from foss.arm.com ([217.140.110.172]:33878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfHURXC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 13:23:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5040D344;
        Wed, 21 Aug 2019 10:23:02 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC56F3F718;
        Wed, 21 Aug 2019 10:23:00 -0700 (PDT)
Subject: Re: [PATCH RFC 2/4] ACPI: APEI: Add ghes_handle_memory_failure to the
 new notification method
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, baicar@os.amperecomputing.com,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
 <20190812101149.26036-3-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <12b3ccff-0cda-0467-a9ba-0682be6f333e@arm.com>
Date:   Wed, 21 Aug 2019 18:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812101149.26036-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 12/08/2019 11:11, Shiju Jose wrote:
> This patch adds ghes_handle_memory_failure to the new error
> notification method.

The commit message doesn't answer the question: why?

The existing code works. This just looks like additional churn.
Given a user, I think the vendor specific example is useful. I don't think making this
thing more pluggable is a good idea.


Thanks,

James
