Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480BB98125
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2019 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfHURWj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 13:22:39 -0400
Received: from foss.arm.com ([217.140.110.172]:33860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfHURWj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 13:22:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B898C344;
        Wed, 21 Aug 2019 10:22:38 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436583F718;
        Wed, 21 Aug 2019 10:22:37 -0700 (PDT)
Subject: Re: [PATCH RFC 0/4] ACPI: APEI: Add support to notify the vendor
 specific HW errors
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, baicar@os.amperecomputing.com,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <72f44e4d-a20b-df1c-ddfe-55219e0ed429@arm.com>
Date:   Wed, 21 Aug 2019 18:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812101149.26036-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 12/08/2019 11:11, Shiju Jose wrote:
> Presently kernel does not support reporting the vendor specific HW errors,
> in the non-standard format, to the vendor drivers for the recovery.

'non standard' here is probably a little jarring to the casual reader. You're referring to
the UEFI spec's "N.2.3 Non-standard Section Body", which refers to any section type
published somewhere other than the UEFI spec.

These still have to have a GUID to identify them, so they still have the same section
header format.


> This patch set add this support and also move the existing handler
> functions for the standard errors to the new callback method.

Could you give an example of where this would be useful? You're adding an API with no
caller to justify its existence.


GUIDs should only belong to one driver.

I don't think we should call drivers for something described as a fatal error. (which is
the case with what you have here)


> Also the CCIX RAS patches could be move to the proposed callback method.

Presumably for any vendor-specific stuff?


Thanks,

James
