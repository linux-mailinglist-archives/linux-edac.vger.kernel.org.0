Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5577D2A9E12
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgKFTdz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 14:33:55 -0500
Received: from foss.arm.com ([217.140.110.172]:43978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgKFTdy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Nov 2020 14:33:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42FD1509;
        Fri,  6 Nov 2020 11:33:53 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 070BB3F802;
        Fri,  6 Nov 2020 11:33:51 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] EDAC/ghes: Add EDAC device for recording the CPU
 error count
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
        rjw@rjwysocki.net, lenb@kernel.org, rrichter@marvell.com,
        linuxarm@huawei.com, jonathan.cameron@huawei.com
References: <20201105174233.1146-1-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <87b00978-8d5d-1917-b801-e6a36f704fb3@arm.com>
Date:   Fri, 6 Nov 2020 19:33:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105174233.1146-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shiju,

On 05/11/2020 17:42, Shiju Jose wrote:
> For the firmware-first error handling on ARM64 hardware platforms,
> CPU cache corrected error count is not recorded.
> Create an CPU EDAC device and device blocks for the CPU caches
> for this purpose. The EDAC device blocks  are created based on the
> CPU caches information represented in the ACPI PPTT.

Using the PPTT won't work on x86 systems. Can we use the core-code's common data to learn
about caches: struct cpu_cacheinfo and struct cacheinfo ?


Thanks,

James
