Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5302E0BF
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE2PNd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 11:13:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfE2PNc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 11:13:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616B8341;
        Wed, 29 May 2019 08:13:32 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51CAB3F5AF;
        Wed, 29 May 2019 08:13:31 -0700 (PDT)
Subject: Re: [PATCH 09/21] EDAC, ghes: Use standard kernel macros for page
 calculations
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-10-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e566fe1d-ed06-53bc-6827-f6dfa32ee485@arm.com>
Date:   Wed, 29 May 2019 16:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529084344.28562-10-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 29/05/2019 09:44, Robert Richter wrote:
> Use standard macros for page calculations.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
