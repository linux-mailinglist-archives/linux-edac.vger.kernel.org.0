Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD23BDF6
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2019 23:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfFJVC3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jun 2019 17:02:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47290 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388311AbfFJVC3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 Jun 2019 17:02:29 -0400
Received: from zn.tnic (p200300EC2F052B00B9C6921F36B00F7C.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2b00:b9c6:921f:36b0:f7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D33841EC050B;
        Mon, 10 Jun 2019 23:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560200548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=My/zaqfQUlS2rX5wnUfgdlwdaINpHGxw4O8r+u5i85Y=;
        b=ez3peKs1TG9g5MkZZozkUhc9z/WiNs6pgSZnJTEwwjm9Z66Pg7bxuXSV/H5lG/iMdNkmb0
        oiZrr6lBve06AD1dY7G0PQfZUQ8yXkTXWtBzBXmMCBhLTIUAkY5fqLN2X9OVuUBbKS2nN4
        nDI8GBHtEw4YhXTKYvZcx0x0YjekZl4=
Date:   Mon, 10 Jun 2019 23:02:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>, Marco Elver <elver@google.com>
Cc:     "jbaron@akamai.com" <jbaron@akamai.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] EDAC, ie31200: Reformat PCI device table
Message-ID: <20190610210220.GJ5488@zn.tnic>
References: <20190610191422.177931-1-elver@google.com>
 <20190610191422.177931-2-elver@google.com>
 <3908561D78D1C84285E8C5FCA982C28F7E996B42@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7E996B42@ORSMSX104.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 10, 2019 at 08:13:42PM +0000, Luck, Tony wrote:
> > Reformat device table after Coffee Lake additions to be more readable.
> 
> I like that you put the reformat second ... if some old version needs a backport
> to get Coffee Lake support they can just take part 1 to get the functionality
> and then decide whether or not to take part 2.
> 
> Both parts:
> 
> Acked-by: Tony Luck <tony.luck@intel.com>

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
