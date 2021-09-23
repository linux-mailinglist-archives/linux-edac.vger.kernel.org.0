Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E95416124
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhIWOix (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhIWOix (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Sep 2021 10:38:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2136C061574;
        Thu, 23 Sep 2021 07:37:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d6800d4c5e0e0616b3501.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:d4c5:e0e0:616b:3501])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 309CD1EC056B;
        Thu, 23 Sep 2021 16:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632407836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HfoPwsxKHCcbtGaxkHIOM1bQ75QFFghWL979CqRbrFw=;
        b=Rx5O0nY0jYGcwQF/bSZi8maFoS15Mo0LtUhi5e0YG9Q+Yq8Ck3sI3RsyTcaBFSB3oH0EmV
        Yld3Ju3Dx5hg8HjdqY8dj0ZSLpHYHfhhZLc+WCOKEOhwNOGpMwoQ699jFogBTuB3ZCer5w
        /QVZE3GiP4L7x3fZ39Cl8wHquNRAnf0=
Date:   Thu, 23 Sep 2021 16:37:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Mukul Joshi <mukul.joshi@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        mchehab@kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YUyRFl3oc2CwFxZz@zn.tnic>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
 <YUyPM7VfYFG/PJmu@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUyPM7VfYFG/PJmu@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 23, 2021 at 02:29:07PM +0000, Yazen Ghannam wrote:
> > +	/*
> > +	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
> > +	 * and error occurred in DramECC (Extended error code = 0) then only
> > +	 * process the error, else bail out.
> > +	 */
> > +	if (!m || !((smca_get_bank_type(m->bank) == SMCA_UMC_V2) &&
> > +		    (XEC(m->status, 0x1f) == 0x0)))
> 
> The MCA_STATUS[ErrorCodeExt] field is bits [21:16], so the mask should be
> 0x3f.
> 
> > +		return NOTIFY_DONE;
> > +
> > +	/*
> > +	 * If it is correctable error, return.
> > +	 */
> > +	if (mce_is_correctable(m))
> > +		return NOTIFY_OK;
> 
> Shouldn't this be "NOTIFY_DONE" if "don't care" about this error?

I think the logic here is to stop calling any further consumers on the
notify chain because this is a GPU correctable error and they can't do
anything about it anyway, right?

Or am I misreading it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
