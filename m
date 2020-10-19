Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0929302F
	for <lists+linux-edac@lfdr.de>; Mon, 19 Oct 2020 23:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbgJSVHd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Oct 2020 17:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732457AbgJSVHd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Oct 2020 17:07:33 -0400
Received: from rric.localdomain (31-208-27-44.cust.bredband2.com [31.208.27.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA44B22282;
        Mon, 19 Oct 2020 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603141652;
        bh=BpXpzdSQ0cflX43+Jt0oiRFEOGNhp55SFpE+MV9AO9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiCsh4G48PMxR3VlWLHFG+K+KITc7jtR1xpfiWW013KHfrdDRh8ENBiJY2kjtz4S1
         qPSDoKlnKWhnQQf3sZh60nA2RjaoXBMdM3s6Bzm8593GEQVekOAK6vWGRiVlCQDh7a
         QRjiebGlj5UuDJ1PazhggsvuGipWPAM88+lu+O94=
Date:   Mon, 19 Oct 2020 23:07:26 +0200
From:   Robert Richter <rric@kernel.org>
To:     trix@redhat.com
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] edac: amd64_edac: remove unneeded break
Message-ID: <20201019210726.lsbpl2rvk62bow7r@rric.localdomain>
References: <20201019193524.13391-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019193524.13391-1-trix@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 19.10.20 12:35:24, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Robert Richter <rric@kernel.org>
