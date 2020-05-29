Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2001E798C
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgE2Jgy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Jgy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 May 2020 05:36:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C9C03E969;
        Fri, 29 May 2020 02:36:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f5e0080f2cd34aea9096d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5e00:80f2:cd34:aea9:96d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D44F1EC03D2;
        Fri, 29 May 2020 11:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590745011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WR2rYnmR84fRbBR+DLvPu8jvRSLWDws/IFkvGq2o1M=;
        b=Oe4gQrLAY5IK+JPWzyE+FOiXwBuK2IUPKaIddch1UBnOSLs0hMZ4xs5V2V8rIaJSjWW2HY
        p23EcSktIOi3d65UNOAS2u75edNFJkw163nIvA/Q/V6bSWRWxwfl22VpGPE/z1FjK/AePv
        RGyKZKQePUd+HIqenEqW+cVq1+tB138=
Date:   Fri, 29 May 2020 11:36:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Qiushi Wu <wu000273@umn.edu>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
Message-ID: <20200529093644.GC9011@zn.tnic>
References: <28ebc99f-c0dd-00b2-7a53-9edf0df36c9c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28ebc99f-c0dd-00b2-7a53-9edf0df36c9c@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 29, 2020 at 11:20:42AM +0200, Markus Elfring wrote:
> * The label “err_out” can be replaced by direct return statement,
>   can't it?

No, it cannot. It keeps the error handling code out-of-line so that the
function body remains readable.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
