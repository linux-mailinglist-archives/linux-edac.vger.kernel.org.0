Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3085026031
	for <lists+linux-edac@lfdr.de>; Wed, 22 May 2019 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfEVJOD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 May 2019 05:14:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45564 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbfEVJOD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 May 2019 05:14:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB9F3374;
        Wed, 22 May 2019 02:14:02 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CF653F575;
        Wed, 22 May 2019 02:14:00 -0700 (PDT)
Subject: Re: [PATCH v2] edac: sifive: Add EDAC platform driver for SiFive SoCs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mchehab@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
References: <1557142026-15949-1-git-send-email-yash.shah@sifive.com>
 <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
 <CAJ2_jOG9Ag0spbh3YCxavUE5XEAUP1pHcgCZ56Nu2u4TqfrzHQ@mail.gmail.com>
 <20190521182132.GB7793@cz.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <1c7eb8ab-6f48-c41a-1d3a-a9b0f5ce8a7f@arm.com>
Date:   Wed, 22 May 2019 10:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521182132.GB7793@cz.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 21/05/2019 19:21, Borislav Petkov wrote:
> On Tue, May 21, 2019 at 11:00:59AM +0530, Yash Shah wrote:
>> The prerequisite patch (sifive_l2_cache driver) has been merged into
>> mainline v5.2-rc1
>> It should be OK to merge this edac driver now.
> 
> James?

Still fine by me:
Reviewed-by: James Morse <james.morse@arm.com>

(...this patch already has my reviewed-by on it...)

I commented that it couldn't be merged in pieces here:
https://lore.kernel.org/lkml/4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com/T/#u

which is what Yash is replying to.


Thanks,

James
