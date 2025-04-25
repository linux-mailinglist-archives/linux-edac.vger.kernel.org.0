Return-Path: <linux-edac+bounces-3722-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B2A9BF05
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 08:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C561BA310F
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A822D4F9;
	Fri, 25 Apr 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQzgQXHZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D89199931;
	Fri, 25 Apr 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564269; cv=none; b=cJPVF5JU1lEQKzcUjGCj16FJoQjbXDUpQxdAddou9Vr8sXek1WeU/157emVCtbVYfuwAId7L88VGJ8635o9fjxH3AEB/18S+Vp3zdi0T3AdZSpAUlcY3vLzOQo/waeAdlB/qi8K7DhNRmTVloLpLJaQ93mefC2IPuK2dR5W1nDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564269; c=relaxed/simple;
	bh=8sSgmRxiv+G/N1fs7B4Sw8hD584Kp0YWF9P/443Nkbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN1UfW55ncdDpVz2OnCN72nDbVkk6gsjaAFvfNtWRJw2yPyLCI3cXSarYeg7qS24+G9p7d5tW57OpezFOXRySooz1s8Svx9pCejPCnCE85MddeyN8uzL7tv8BCrlxvXFRhOhreUEg2cr1AbFh31oAOSqDn4S6SZvHxdgMNFJsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQzgQXHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A083C4CEE4;
	Fri, 25 Apr 2025 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745564268;
	bh=8sSgmRxiv+G/N1fs7B4Sw8hD584Kp0YWF9P/443Nkbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQzgQXHZD6po0DjMItq+ZKAVR6QygkxKeBXhEhoe73QyOHjw8ctBgCt6spfcbyUE2
	 WqySlVG+JqrDmtS4V6LisY0rkGA9h7hb8z2T/ilRCovjHkI9tne43xUCetRHUiFTqA
	 AQbSxAG6qEJ+anQDdFDfi49prFwH2c4V9CXThxhUm7W8T0MKga0rxzScgSdEa0Srfj
	 vKF/kxeq5Pb8TxIslR/GW3Q0grUhgjBRbRwF7OWrBUBaPXG9K5IUzHmVVsiLfgDM3M
	 cQto9p383bYXTn65aF0zHNQASM+U7i4eW/BOgOse0Cx+2jjcw2YqArK6V1IJnIWyJl
	 h8dri5ipEIiaQ==
Date: Fri, 25 Apr 2025 08:57:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com, ptsm@linux.microsoft.com, srivatsa@csail.mit.edu, 
	shubhrajyoti.datta@gmail.com, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v6 3/6] cdx: Export Symbols for MCDI RPC and
 Initialization
Message-ID: <20250425-terrestrial-resourceful-mouse-baa637@kuoka>
References: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
 <20250424132118.17074-4-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424132118.17074-4-shubhrajyoti.datta@amd.com>

On Thu, Apr 24, 2025 at 06:51:15PM GMT, Shubhrajyoti Datta wrote:
> The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions are
> needed by VersalNET EDAC modules that interact with the MCDI (Management
> Controller Direct Interface) framework. These functions facilitate
> communication between different hardware components by enabling command
> execution and status management.

Missing header update - these functions now need kerneldoc and be in
globally accessible header. If your earlier patch did it, then I think
patches are not split correctly. Logically these are the same, one
change: export entire interface (symbol and declaration).

Best regards,
Krzysztof


