Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34EF145A7F
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2020 18:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVRDE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jan 2020 12:03:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54626 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726083AbgAVRDE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jan 2020 12:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579712582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWiH6GhAFCgnJrxuq8RYkBkdPUMZBLGGmuvb0dwUfcA=;
        b=IK/FwE0X7EY3jMAg6aOyKlVG1XUu3j5jAMMRx3SrV+Y+Ox4z0n24pRgk+dJCrsIEenDq86
        Elblf2+VHSIIW1FcSo8YxfZ2NoE9zlGR/zpEsU5qqQi4amLcapH62i0Aa/nsckDRrD0Nmq
        4IDfWXBsUeLjSOWVlHbIX0W60A3ijiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-rR6dfSXFMcarOKze0rXmQg-1; Wed, 22 Jan 2020 12:02:54 -0500
X-MC-Unique: rR6dfSXFMcarOKze0rXmQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7539F18CA26E;
        Wed, 22 Jan 2020 17:02:52 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C45D1CB;
        Wed, 22 Jan 2020 17:02:52 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id AAB1DC0E93; Wed, 22 Jan 2020 12:02:51 -0500 (EST)
Date:   Wed, 22 Jan 2020 12:02:51 -0500
From:   Aristeu Rozanski <aris@redhat.com>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] EDAC: Rework core and ghes drivers, part two
Message-ID: <20200122170251.a4ezf3epukx2iobc@redhat.com>
References: <20191205093739.4040-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205093739.4040-1-rrichter@marvell.com>
User-Agent: NeoMutt/20191207
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 05, 2019 at 09:37:55AM +0000, Robert Richter wrote:
> This patch set is part two of a rework of the ghes_edac and edac_mc
> driver. It addresses issues found during code review and while working
> with the code. Part one has been included to v5.5, see:
> 
>  https://lore.kernel.org/patchwork/cover/1093488/
> 
> The changes of this series include:
> 
>  * add helper functions and factor out code (#1, #2, #5)
> 
>  * improve function interfaces and data structures to decrease
>    complexity such as number of function arguments, unused data, etc.
>    (#3, #4, #7, #8, #9, #10),
> 
>  * minor functional fixes (#6)
> 
>  * improve code readability (#9)
> 
> V2:
>  * fixed documentation issue in #3 found by "kbuild test robot
>    <lkp@intel.com>"
> 
> Changes compared to part one:
>  * rebased onto 5781823fd0d3 ("EDAC/altera: Use the Altera System
>    Manager driver")
>  * reworded patch subjects
>  * reordered patches
>  * collected Mauro's Reviewed-by-tags (note: I kept them though there
>    has been small conflicts but dropped it when reworked)
>  * dropped: "EDAC/mc: Rework edac_raw_mc_handle_error() to use struct
>    dimm_info"
>  * split "EDAC/mc: Remove per layer counters" into smaller changes
>  * added:
>    "EDAC/mc: Report "unknown memory" on too many DIMM labels found"
>    "EDAC/mc: Remove enable_per_layer_report function arguments"
>    "EDAC/mc: Pass the error descriptor to error reporting functions"
>    "EDAC/mc: Remove detail[] string and cleanup error string
>    generation"
>  * moved to the end:
>    "EDAC/mc: Remove per layer counters"
> 
> 
> Robert Richter (10):
>   EDAC/mc: Split edac_mc_alloc() into smaller functions
>   EDAC/mc: Reorder functions edac_mc_alloc*()
>   EDAC: Store error type in struct edac_raw_error_desc
>   EDAC/mc: Determine mci pointer from the error descriptor
>   EDAC/mc: Create new function edac_inc_csrow()
>   EDAC/mc: Report "unknown memory" on too many DIMM labels found
>   EDAC/mc: Remove enable_per_layer_report function arguments
>   EDAC/mc: Pass the error descriptor to error reporting functions
>   EDAC/mc: Remove detail[] string and cleanup error string generation
>   EDAC/mc: Remove per layer counters
> 
>  drivers/edac/edac_mc.c       | 496 ++++++++++++++++-------------------
>  drivers/edac/edac_mc.h       |   6 +-
>  drivers/edac/edac_mc_sysfs.c |  20 +-
>  drivers/edac/ghes_edac.c     |  16 +-
>  include/linux/edac.h         |   9 +-
>  5 files changed, 249 insertions(+), 298 deletions(-)

Acked-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu

