Return-Path: <linux-edac+bounces-1518-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05016932397
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 12:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877D2B20CDF
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57B197A86;
	Tue, 16 Jul 2024 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAUu3L2F"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5CF195B3B
	for <linux-edac@vger.kernel.org>; Tue, 16 Jul 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124528; cv=none; b=I+kLe779b8WB9bAekySvPCGFHxeax1y0sabV6OU2vhDW1d8iHwxJ4pN+HiBbN0d50YPba5UjPMMEEGwKG1SLzt83dQX0fSREbQggvHNyw2eYf88DKD3o22q+iFca26oYICzzz+qbDbVYTWoGSeFyU20XJlUfS56zxJgBPfSEj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124528; c=relaxed/simple;
	bh=jAtU9YcLhveuAdAgK8iT9oy+B0iaw/i1cUAOg4I7tmA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Euq21UK/74UDC3gCju8W8NKE2DhXsYn8V38zl2t5h4hzI+g9C4i9ZQo31GDHbIFEitDsYi3m5UEmbG2G/5CopcehM1HRK67R7jC3SunhvTSYxt6G3OfULhKFCp9BK2rsoYRPLggzWPv98o3kghrpaqjd6KgQjewqMv9gSdti5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAUu3L2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC620C116B1
	for <linux-edac@vger.kernel.org>; Tue, 16 Jul 2024 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721124528;
	bh=jAtU9YcLhveuAdAgK8iT9oy+B0iaw/i1cUAOg4I7tmA=;
	h=Date:From:To:Subject:From;
	b=uAUu3L2FCTfSDmP+tYDD7tYMpZiEhJoyCM62I/Ys/In+UFI9DLyUWDTStE1kbQuQS
	 cXaYFlMsbfvvhkPzGSbM3+ByTi7No6tsSjLwcMHtJ/Hn3bmqICoLrz7Za14BxiPEJh
	 10hhewsNWfHMMv9f0zADi+5wFbP4lnfaJTrN9FbwAfmNiHEa+5ZPV5x3qNNaj9rBs+
	 u5WP/smVwmJooomZCPZ7d2YiDGBpw5XFEN6XyHz5916HmQzcn2VmOgUc3ZA8n6t512
	 m5y0ikd025zX+4pKVeefiFqnppyq7eGXrjD1/UnL42nbxAXDqqc1B2BIKL9fypnRAW
	 fmD9HoqBmXJpQ==
Date: Tue, 16 Jul 2024 12:08:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: linux-edac@vger.kernel.org
Subject: [ANN] Rasdaemon version 0.8.1 released
Message-ID: <20240716120840.73101250@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

Just released today a new version of the rasdaemon with:

	* Lots of new labels added;
	* Added a script to check coding style;
	* Detect non-x86 CPUs on MCE handler;
	* Added an error injection script for QEMU;
	* Allow external scripts to handle memory errors;
	* Fix ARM processor compatibility with upstream;
	* Add support for CXL events;
	* Add support for microcode and PPIN on MCE traces;
	* Add non-standard decodes for Yitian and Jaguarmicro;
	* Add EmeraldRapids Intel CPU;
	* Add Corrected Internal Error for aer_cor_errors;
	* Add support for disable ras events in runtime;
	* Improve AMD SMCA handling;
	* Fix several compilation and runtime issues;
	* Add option on ras-mc-ctl to exclude old events from reports;
	* Other improvements at ras-mc-ctl tool;
	* Documentation updates;
	* Code cleanups;
	* Coding style cleanups.

The main git repository is hosted at:

	https://github.com/mchehab/rasdaemon

Source tarballs at:

	https://www.infradead.org/~mchehab/rasdaemon/

Thanks,
Mauro

