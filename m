Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9ABB187E32
	for <lists+linux-edac@lfdr.de>; Tue, 17 Mar 2020 11:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgCQKWx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 06:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgCQKWw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Mar 2020 06:22:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82D3205ED;
        Tue, 17 Mar 2020 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584440572;
        bh=3JhdNYW35Xr7cHItOJ5k+T6/2/lATLnR5LeNQ/kmzqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEAsPeRiKFScbRUEAjJzdfuOTDSm/yKlJrtz84TKJKzeqEsVKi5cPStIAg4wbA7wk
         +4QEMjYV9+OpLSVA0brQzzDOLlRCuyAg5KuhBmloFa5fbvPH0mZhkWHF+gqNKMD+Mx
         Er6BDZZ6SxNhW3g2CcE3EEpXQVBovZm0IzpGFy9E=
Date:   Tue, 17 Mar 2020 11:22:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manali K Shukla <manashuk@cisco.com>
Cc:     bp@alien8.de, linux-edac@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com,
        Borislav Petkov <bp@suse.de>,
        Aristeu Rozanski Filho <arozansk@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Russ Anderson <rja@hpe.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Message-ID: <20200317102249.GC1130294@kroah.com>
References: <20200312052201.49456-1-manashuk@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312052201.49456-1-manashuk@cisco.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 11, 2020 at 10:22:01PM -0700, Manali K Shukla wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> upstream 861e6ed667c83d64a42b0db41a22d6b4de4e913f commit
> 
> ... and use the single edac_subsys object returned from
> subsys_system_register(). The idea is to have a single bus
> and multiple devices on it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> CC: Aristeu Rozanski Filho <arozansk@redhat.com>
> CC: Greg KH <gregkh@linuxfoundation.org>
> CC: Justin Ernst <justin.ernst@hpe.com>
> CC: linux-edac <linux-edac@vger.kernel.org>
> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> CC: Russ Anderson <rja@hpe.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Link: https://lkml.kernel.org/r/20180926152752.GG5584@zn.tnic
> [Manali: backport to v4.19 -stable :
> - removing per-MC bus, this enables to get rid of memory controllers
>   maximum number notion
> - value of max number of memory controllers is 2 * MAX_NUMNODES. On two nodes system MAX_NUMNODES value is ‘1’ and
>   so value of max number of memory controller becomes ‘2’, this patch fixes this issue when there are only 2 nodes on the system
>   and number of memory controllers are more than ‘2’]
> (cherry picked from commit 861e6ed667c83d64a42b0db41a22d6b4de4e913f)
> Signed-off-by: Manali K Shukla <manashuk@cisco.com>

Why is this a patch for the stable trees?  What problem does it solve?

thanks,

greg k-h-
