Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5657FE64
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jul 2022 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiGYLau (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jul 2022 07:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGYLat (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jul 2022 07:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7C6645F;
        Mon, 25 Jul 2022 04:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F84760FE3;
        Mon, 25 Jul 2022 11:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A887C341C6;
        Mon, 25 Jul 2022 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658748647;
        bh=5hDMUOyyB40Eij6YGxOkgIHj6Qw1urzONH79uh0stsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFGMF1UqjZpHRSOPowS11Ask1ghJ47MGDgUiNJ3dqh6JKQZq6dXvwqevGfsO/tx1I
         MElHOLkExiLxLU3oDGJ/vxaxWq96he+6yssg6wBnt1aQYE+h0Z6fnW1Ef2GAIVnUS2
         IfZNLIVN6L1wr2arlA4TWrcL+iatS4mwOOSfy1y1qp8QMLBjXnFHtenVtYblyIjSC8
         v7kCGQ8P+TxWz+4N8pnZCa+m6dEV/Hdzc54ZMXAgZaMilVv/CXRmAIa6xGU/ejKIJh
         6NCZygiKPuWhwYKR9iwHuppE8MXjr1Wq+mHR4adMvm81ZyKIVdJey4htpxGApV8fk0
         9gzD85whVTYMA==
Date:   Mon, 25 Jul 2022 13:30:41 +0200
From:   Robert Richter <rric@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org,
        elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <Yt5+4feA3Qux743w@rric.localdomain>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic>
 <Yt5oAjbZ5Koy9v5i@rric.localdomain>
 <Yt5s/f/jyRcFY1Md@zn.tnic>
 <Yt50Pp3kQRCtSqw6@rric.localdomain>
 <Yt5510+uLKzv+Qvt@rric.localdomain>
 <Yt59LiHs3gWNpNW1@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt59LiHs3gWNpNW1@zn.tnic>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 25.07.22 13:23:26, Borislav Petkov wrote:
> On Mon, Jul 25, 2022 at 01:09:11PM +0200, Robert Richter wrote:
> > I see now, what you mean here, may be change this:
> > 
> > 	snprintf(dimm->label, sizeof(dimm->label), "%s %s",
> > 		 (bank && *bank) ? bank : "N/A",
> > 		 (device && *device) ? device : "N/A");
> > 
> > to:
> > 
> > 	snprintf(dimm->label, sizeof(dimm->label), "%s%s%s",
> > 		 (bank && *bank) ? bank : "",
> > 		 (bank && device) ? " " : "",
> > 		 (device && *device) ? device : "");
> > 
> > It keeps the default assignment from edac_mc_alloc_dimms() but changes
> > we label if one of bank or device is given.
> 
> Yap, that should take care of all possible "configurations" BIOS throws
> at us.
> 
> Toshi, could you pls add this to the fix and test it on your machine to
> make sure it still works as expected?

If you like, you can add my:

Signed-off-by: Robert Richter <rrichter@amd.com>

-Robert
