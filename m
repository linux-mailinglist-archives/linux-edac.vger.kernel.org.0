Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785B2180901
	for <lists+linux-edac@lfdr.de>; Tue, 10 Mar 2020 21:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgCJUTG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Mar 2020 16:19:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726325AbgCJUTF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Mar 2020 16:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583871544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgP1T+wGC2P5ovvcZBFXxUKVKB4+9CKMKrqQw1DXEe0=;
        b=CIcK+SDf5A2QdO4pmcQ2rQpbWeUbTTWxLAmhAEOdxcBjOkLPw5I3w4xAGSNOMtQmBMWBU6
        PF9iWwa8NIxzd2O/hC6iuiBQFMsiJCyfrHxn/GMk1AMYOXC29HwyMRmM8iNVBXjwajR6/b
        sQlG2qjZliun3Z9qY5I83Juxp/EA+J8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-0yXbyAw7NhyCLXKNwJvhag-1; Tue, 10 Mar 2020 16:18:56 -0400
X-MC-Unique: 0yXbyAw7NhyCLXKNwJvhag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28F77107ACC4;
        Tue, 10 Mar 2020 20:18:55 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C86837388F;
        Tue, 10 Mar 2020 20:18:54 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 2EE9DC0E48; Tue, 10 Mar 2020 16:18:54 -0400 (EDT)
Date:   Tue, 10 Mar 2020 16:18:54 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] EDAC/ghes: Cleanup, rework and improvement of
 memory reporting
Message-ID: <20200310201854.etpclthuj577lpds@redhat.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306151318.17422-1-rrichter@marvell.com>
User-Agent: NeoMutt/20191207
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 06, 2020 at 04:13:07PM +0100, Robert Richter wrote:
> This series contains a significant cleanup and rework of the ghes
> driver and improves the memory reporting as follows:
> 
>  * fix of DIMM label in error reports (patch #2),
> 
>  * creation of multiple memory controllers to group DIMMs depending on
>    the physical memory array (patches #9-#11). This should reflect the
>    memory topology of a system in sysfs. Esp. multi-node systems show
>    up with one memory controller per node now.
> 
> The changes base on the remaining patches that are a general cleanup
> and rework:
> 
>  * small change to edac_mc, not really dependent on the rest of the
>    series (patch #1),
> 
>  * general cleanup and rework of the ghes driver (patches #3-#8).
> 
> The implementation of multiple memory controllers bases on the
> suggestion from James (see patch #11), thank you James for your
> valuable input here. The patches are created newly from scratch and
> obsolete the GHES part of my previous postings a while ago that have
> not been accepted upstream:
> 
>  https://lore.kernel.org/patchwork/cover/1093488/
> 
> Tested on a Marvell/Cavium ThunderX2 Sabre (dual socket) system.

Acked-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu

