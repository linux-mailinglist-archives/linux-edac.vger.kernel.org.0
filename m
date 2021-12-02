Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77386466A01
	for <lists+linux-edac@lfdr.de>; Thu,  2 Dec 2021 19:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhLBSuD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Dec 2021 13:50:03 -0500
Received: from mail.ispras.ru ([83.149.199.84]:47378 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233228AbhLBSuC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Dec 2021 13:50:02 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 541F740A2BB7;
        Thu,  2 Dec 2021 18:46:35 +0000 (UTC)
Date:   Thu, 2 Dec 2021 21:46:35 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Excessive delays from GHES polling on dual-socket AMD EPYC
In-Reply-To: <Yajt9zml8Iyd/VVn@yaz-ubuntu>
Message-ID: <52c4a144-72f5-e778-35c2-4159108912e6@ispras.ru>
References: <878e4019-3a88-798e-4427-7efb5289a4e1@ispras.ru> <Yajt9zml8Iyd/VVn@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2 Dec 2021, Yazen Ghannam wrote:

> I believe the large number of GHES structures you have are intended to be used
> for the ACPI "GHES_ASSIST" feature. The GHES structures in this case are not
> to be used as independent sources. However, this feature is not implemented
> yet in Linux, so the kernel does set up these GHES structures as independent
> error sources.

Yes, our HEST has "GHES Assist: 1". But it is disappointing those sources have
"Polled" type, ACPI allocated eight bits for the type, and only 12 types are
registered so far, so it's not like they were running out of space to designate
a separate type for this kind of sources.

[snip increasing polling interval]

> Ultimately, I think we'd want the kernel to ignore the GHES structures used
> for GHES_ASSIST, and then GHES_ASSIST support can be implemented and used
> where appropriate.
> 
> I can send a patchset for ignoring the structures. This would be setup for
> another set than can fully implement the GHES_ASSIST feature. Would you be
> willing to test out that first set to see if it resolves the issue?

Sure, please Cc me on the patches.

Alexander
