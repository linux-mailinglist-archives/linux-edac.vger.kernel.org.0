Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A92E0BB
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfE2PNG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 11:13:06 -0400
Received: from foss.arm.com ([217.140.101.70]:47912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2PNF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 11:13:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91E53341;
        Wed, 29 May 2019 08:13:04 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EFAB3F5AF;
        Wed, 29 May 2019 08:13:03 -0700 (PDT)
Subject: Re: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-13-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <92eda11f-dad9-bb2b-3a87-80b6c8d8e228@arm.com>
Date:   Wed, 29 May 2019 16:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529084344.28562-13-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 29/05/2019 09:44, Robert Richter wrote:
> The ghes driver is not able yet to count legacy API counters in sysfs,
> e.g.:
> 
>  /sys/devices/system/edac/mc/mc0/csrow2/ce_count
>  /sys/devices/system/edac/mc/mc0/csrow2/ch0_ce_count
>  /sys/devices/system/edac/mc/mc0/csrow2/ch1_ce_count
> 
> Make counting csrows/channels generic so that the ghes driver can use
> it too.

What for?

Is this for an arm64 system? Surely we don't have any systems that used to work with these
legacy counters. Aren't they legacy because we want new software to stop using them!


Thanks,

James
