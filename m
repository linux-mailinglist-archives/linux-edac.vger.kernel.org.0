Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDE565B2
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2019 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFZJdm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jun 2019 05:33:42 -0400
Received: from foss.arm.com ([217.140.110.172]:57366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZJdl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Jun 2019 05:33:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A6CC0A;
        Wed, 26 Jun 2019 02:33:41 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EEE23F718;
        Wed, 26 Jun 2019 02:33:40 -0700 (PDT)
Subject: Re: [PATCH v2 24/24] EDAC, ghes: Disable legacy API for ARM64
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-25-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <a4a99baf-757a-90f2-6172-c1e6814e5e1c@arm.com>
Date:   Wed, 26 Jun 2019 10:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624150758.6695-25-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 24/06/2019 16:09, Robert Richter wrote:
> James Morse: "I'm all for removing/warning-its-broken it when
> ghes_edac is in use."

Thanks for taking that out of context. The very next word was 'but':
http://lore.kernel.org/r/c08290d8-3690-efa9-3bc7-37f8b1fdbfd4@arm.com

followed by details of the user-space that is still using this.


> Let's just disable legacy API for the ghes driver on arm64. Though, I
> don't agree with it as there still could be some userland tools that

Not could. Are. Someone went and found them for you.


> use this interface that cannot be used any longer after a transition
> from x86 to arm64.
