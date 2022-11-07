Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EDA61F37B
	for <lists+linux-edac@lfdr.de>; Mon,  7 Nov 2022 13:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKGMiJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Nov 2022 07:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiKGMiH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Nov 2022 07:38:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ABD183AC
        for <linux-edac@vger.kernel.org>; Mon,  7 Nov 2022 04:38:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FEECB810CF
        for <linux-edac@vger.kernel.org>; Mon,  7 Nov 2022 12:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4423AC433C1;
        Mon,  7 Nov 2022 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667824679;
        bh=vRfJHUKxmqOZ8dLj49WPZCBk2RGzFEoFlQASjKjhQRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udUFFS6L9BwIcTeapVLl8ng+E+geoI28jG1/hoJZeHirPdfsp6ePU768DvanjMzo7
         Z2Fw790aLsyycK7fCt7M+zzuLPW1qbkVUwHJ2aY82RfCL5d/3BQ38/GngKh/dkp0rx
         wiWqUY1U+Sp8xRDUcGoJSLWUsmDChhuYWAFjTroo=
Date:   Mon, 7 Nov 2022 13:37:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>
Cc:     James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH v1 2/2] EDAC/bluefield_edac: Update license and copyright
 info
Message-ID: <Y2j8JJZKUrkKk4Ze@kroah.com>
References: <cover.1667561793.git.shravankr@nvidia.com>
 <9d584ef2522e2cdc9aa28d3f952ab98b17d961a2.1667561793.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d584ef2522e2cdc9aa28d3f952ab98b17d961a2.1667561793.git.shravankr@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 07, 2022 at 04:02:54AM -0500, Shravan Kumar Ramani wrote:
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>

For obvious reasons, we can't take patches without any changelog text,
and you know this :(

But a meta-comment.  You are changing the license and copyright of a
file, without any info at all as to why this is allowed.

Please get your legal council to sign off on such a change in order to
have this be able to be properly reviewed.  Please include the
justification for why the license change is allowed, and why the
copyright change is allowed (hint, they are vastly different things, and
really should be two different patches.)

Without that information, changes like this are not allowed, and you
want that to be the case.

So please work with your lawyers and please cc: me on future license
and copyright changes like this.

thanks,

greg k-h
