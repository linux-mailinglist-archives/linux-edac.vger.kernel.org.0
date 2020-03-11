Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648F2181A73
	for <lists+linux-edac@lfdr.de>; Wed, 11 Mar 2020 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgCKNy6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 11 Mar 2020 09:54:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36901 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgCKNy6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Mar 2020 09:54:58 -0400
Received: from [2001:67c:670:100:60fd:6250:7fff:c5e5] (helo=rettich)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1jC1ou-0000ST-M1; Wed, 11 Mar 2020 14:54:48 +0100
Received: from jlu by rettich with local (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1jC1or-0005Du-7v; Wed, 11 Mar 2020 14:54:45 +0100
Message-ID: <f4bc27711bd66d8741aebee370615cca35084685.camel@pengutronix.de>
Subject: Re: [PATCH] EDAC: armada_xp: Use scnprintf() for avoiding potential
 buffer overflow
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Date:   Wed, 11 Mar 2020 14:54:45 +0100
In-Reply-To: <20200311071728.4541-1-tiwai@suse.de>
References: <20200311071728.4541-1-tiwai@suse.de>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:60fd:6250:7fff:c5e5
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2020-03-11 at 08:17 +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Yes, this is better.

Reviewed-by: Jan Luebbe <jlu@pengutronix.de>

Thanks!

Jan
-- 
Pengutronix e.K.                        | Dipl.-Inform. Jan Lübbe     |
Steuerwalder Str. 21                    | https://www.pengutronix.de/ |
31137 Hildesheim, Germany               | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686        | Fax:   +49-5121-206917-5555 |
