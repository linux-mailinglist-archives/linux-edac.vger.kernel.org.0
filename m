Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A3179B2
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2019 14:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfEHMrl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 May 2019 08:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfEHMrl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 May 2019 08:47:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A4620644;
        Wed,  8 May 2019 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557319660;
        bh=dnvIXgHZ2nj3mMk0IxGgiKgWOqscukd4p+bqGXdACeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsduZ/NZYINzSM0PwseSZGuZCr1lxjgTY4zcngITEXQbYQ5LAAVHjuXTGOXkZO7oM
         Cd82T/Hasjc6Uoa9XByq+oIBghtUe9TiEq04EHSaPTNNV3FJcfggSFrzYAY9YJcCHw
         HUnLabX0Hh3N/z6D3VEwbRhF1CZi/++b9CsJwR6E=
Date:   Wed, 8 May 2019 14:47:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     PanBian <bianpan2016@163.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] EDAC/sysfs: Drop device references properly
Message-ID: <20190508124738.GC8646@kroah.com>
References: <1555554438-103953-1-git-send-email-bianpan2016@163.com>
 <20190418172548.GL27160@zn.tnic>
 <20190419003536.GA57795@bianpan2016@163.com>
 <20190419004516.GC559@zn.tnic>
 <20190427214925.GE16338@kroah.com>
 <20190508110605.GE19015@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508110605.GE19015@zn.tnic>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 08, 2019 at 01:06:05PM +0200, Borislav Petkov wrote:
> --
> From: Greg KH <gregkh@linuxfoundation.org>
> 
> Do put_device() if device_add() fails.
> 
>  [ bp: do device_del() for the successfully created devices in
>    edac_create_csrow_objects(), on the unwind path. ]

Yes, good catch, looks good, thanks!

greg k-h
