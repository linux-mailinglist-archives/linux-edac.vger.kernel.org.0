Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C343BC39
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2019 20:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfFJSyw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jun 2019 14:54:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbfFJSyw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 Jun 2019 14:54:52 -0400
Received: from zn.tnic (p200300EC2F052B000C22B0A0C73B2F50.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2b00:c22:b0a0:c73b:2f50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9C711EC0982;
        Mon, 10 Jun 2019 20:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560192890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=D/d9B+8ZEwQPPv8fSIn75evRhCraI+XhtzPfi8jLWFE=;
        b=cJ3okDV4nOKvGnDYJodE+nHUyr56JbAZGKkYMe8i+1KN8BgeNg4ipKZEIoP95EXrz2C4vZ
        84w0rgAXLvapRilvuDubUs5kKmrf8/aukE66ZaIG/VP0rgAeZOoGHGHb3s/Tq6qy0SkzFb
        zYbLMThrM/FyNS8Amm/7rWB84Osh5Y4=
Date:   Mon, 10 Jun 2019 20:54:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, jbaron@akamai.com,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] EDAC, ie31200: Add Intel Coffee Lake CPU support
Message-ID: <20190610185444.GG5488@zn.tnic>
References: <20190609151613.195164-1-elver@google.com>
 <20190610180121.GA22428@agluck-desk2.amr.corp.intel.com>
 <CANpmjNOVjcgprWviex0uPCCAC4+qW=sh6d+BdYtZATNd-w_hbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNOVjcgprWviex0uPCCAC4+qW=sh6d+BdYtZATNd-w_hbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 10, 2019 at 08:37:01PM +0200, Marco Elver wrote:
> Yes. Originally I had a version that added the new entries in the same
> style as before, but failed check_patch.pl due to exceeding 80 chars.

Don't trust checkpatch blindly, especially about this rule. It is
perfectly fine to leave a block of code like that stick out and even
make it more tight since it is very visible which column differs if you
keep the macro arguments aligned vertically:

static const struct pci_device_id ie31200_pci_tbl[] = { 
        { PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
        { PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
        { PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
        { PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
	...

your new additions would then need to do:

	...
        { PCI_VEND_DEV(INTEL, IE31200_HB_4),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
	...

to keep that vertical alignment.

> I'll send v2 that reverts the formatting, but has to break line after
> the 2nd PCI_ANY_ID for the new entries. I'd prefer not to introduce
> another macro.

Yes, but as Tony said, keep formatting changes separate from the patch
adding the Coffee Lake support.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
