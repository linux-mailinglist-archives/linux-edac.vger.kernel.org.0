Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BE484029
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jan 2022 11:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiADKwD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jan 2022 05:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiADKwD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jan 2022 05:52:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDF7C061761;
        Tue,  4 Jan 2022 02:52:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2760BB811AC;
        Tue,  4 Jan 2022 10:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614DAC36AEB;
        Tue,  4 Jan 2022 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641293521;
        bh=Cs158w+IWfdALjYr6HnueI2ujWstThB/m7DpYYq5tTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xge1MchzuECyRDDimN36Hbp0pWjviHS4D8gwEojw/oz5/kq9V0xDar+miloMxOf+F
         gyauJI2kS00vCRo2gfJOJVJQLqcJDCIIPI8jLWFegBgpWzzDYHdKC9bCZkJnT/Fy7a
         nEVF2ZrVODrLHeiQwX4eBW7KvivPo7tNMqkFo6QQ=
Date:   Tue, 4 Jan 2022 11:51:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/2] EDAC: use proper list of struct attribute for
 attributes
Message-ID: <YdQmzoNOBHLwgv7p@kroah.com>
References: <20220104103822.1009971-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104103822.1009971-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 04, 2022 at 11:38:21AM +0100, Greg Kroah-Hartman wrote:
> The edac sysfs code is doing some crazy casting of the list of
> attributes that is not necessary at all.  Instead, properly point to the
> correct attribute structure in the lists, which removes the need to cast
> anything and the code is now properly typesafe (as much as sysfs
> attribute logic is typesafe...)
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/edac/edac_device_sysfs.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Ick, I forgot the other users like edac_pci_sysfs.c that also has this
issue, so let me go fix up this series to include that at the same time.
Sorry for the noise here...

thanks,

greg k-h
