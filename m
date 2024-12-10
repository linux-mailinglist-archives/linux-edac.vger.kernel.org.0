Return-Path: <linux-edac+bounces-2681-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21399EB69E
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 17:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739B5188727A
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7481C5F30;
	Tue, 10 Dec 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz1d8Juz"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786B1BDABE;
	Tue, 10 Dec 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848656; cv=none; b=F5X8qpXP9NQG5W0h9TQ8H3HBjHsUJI5Qu6UVYX8tWS79rqGUDEX8h3ZAwyCSJXiBuzBBw6KzcUH439I3lbg1A0664UrPkQ2kpPLvp/SGfqLFIdVUO4KD56r/9jbnSOFX/4BY73ikl5yPVnG2ZBictuApw8ys38zKC3kIM1Wllq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848656; c=relaxed/simple;
	bh=MpjaKk7cYVbdE3GJCoyN8FReQ8QSVbfdgLJdLgGBhWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PNy6VhbrK3O6TfqAIZGrKLq42ymr6/jpMn3YpxMH36jmv87AKC8Mym2kAaERlROjL1+Ux67n0+6LhTE/RWl8XMN8CBWQNci+NjUKNQbXjKy9AIN7Zd29I7J9t6DXiqchraOYgaPlhdKa/5wWDXlob81s8R0icHs5XD8Nc5YCyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz1d8Juz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F18AC4CED6;
	Tue, 10 Dec 2024 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733848655;
	bh=MpjaKk7cYVbdE3GJCoyN8FReQ8QSVbfdgLJdLgGBhWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gz1d8JuziAphylEjEF7B7BQqTxIYY7Trtru/YIrM8k+ROuMaOX9yTpGIpfzm5Ygf+
	 lTFi9KBrJm+wXylFvc4LHyoqpMg6K7xvKeqBYU0/gvYHv5Y1eoyPWo9vaEkiYEQTKE
	 sGPu/EkDINd6D3AWM4sOQhl+tD3cR2PgEMa9quhT+iSna+kcIUzSQaSswqraLsEVpJ
	 TCCexVKL7jTc7lX+y4bTYCGGyfRd255RAntolZK3GCzV/F78jZKSgv87LmW2P96m28
	 dQ4VVniFe2e3zUKidWjthS19Vm8bsYKkoadKvFgKRRz56o8XGqJjatmOtmO2iiOycq
	 HR6bJJ1Gr3e+A==
Date: Tue, 10 Dec 2024 10:37:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Meyer, Kyle" <kyle.meyer@hpe.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Message-ID: <20241210163734.GA3244835@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60832217752DE71A4ED1054CFC312@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Dec 06, 2024 at 10:09:23PM +0000, Luck, Tony wrote:
> What we need here is a function that maps from a PCIe device to a CPU socket.
> 
> Has this problem been encountered before? Is there an existing solution?

There's nothing in PCI itself that connects a device to a CPU.  It
sounds like something that might fit with an ACPI NUMA description,
e.g., if a CPU and a PCI host bridge had the same ACPI _PXM value, you
could conclude that the devices below the host bridge are close to the
CPU.

Bjorn

