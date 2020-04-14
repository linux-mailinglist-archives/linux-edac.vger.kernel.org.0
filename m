Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA811A75EC
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436685AbgDNIYU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 04:24:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39375 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436635AbgDNIXm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Apr 2020 04:23:42 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1jOGqw-0006xY-H3; Tue, 14 Apr 2020 10:23:30 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1jOGqt-0001Tv-0u; Tue, 14 Apr 2020 10:23:27 +0200
Message-ID: <194227480763959985358ec7140040918ac73337.camel@pengutronix.de>
Subject: Re: [PATCH] EDAC/armada_xp: Fix some log messages
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Tue, 14 Apr 2020 10:23:26 +0200
In-Reply-To: <20200413041556.3514-1-christophe.jaillet@wanadoo.fr>
References: <20200413041556.3514-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 2020-04-13 at 06:15 +0200, Christophe JAILLET wrote:
> Fix some spelling (s/Aramda/Armada/) in 1 log message and in 1
> comment.
> 
> While at it, add some trailing '\n' in some other log message.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jan Luebbe <jlu@pengutronix.de>

Thanks,

Jan

